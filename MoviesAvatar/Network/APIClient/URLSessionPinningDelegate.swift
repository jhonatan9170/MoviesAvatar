import Foundation
import Security
import CommonCrypto

class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    let pinnedPublicKeyHash = Constants.pinnedPublicKeyHash
    let rsa2048Asn1Header:[UInt8] = [
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
    ]
    private func sha256(data : Data) -> String {
        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(data)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))

        keyWithHeader.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(keyWithHeader.count), &hash)
        }
        return Data(hash).base64EncodedString()
    }
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)
                if(errSecSuccess == status) {
                    print(SecTrustGetCertificateCount(serverTrust))
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {

                        let serverPublicKey = SecCertificateCopyKey(serverCertificate)
                        let serverPublicKeyData:NSData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil )!
                        let keyHash = sha256(data: serverPublicKeyData as Data)
                        if (keyHash == pinnedPublicKeyHash) {
                            completionHandler(.useCredential, URLCredential(trust:serverTrust))
                            return
                        }
                    }
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
