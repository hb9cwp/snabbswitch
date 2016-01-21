### IPsec/ESP (lib.ipsec.esp)

The `lib.ipsec.esp` module contains two classes `esp_v6_encrypt` and
`esp_v6_decrypt` which implement implement packet encryption and
decryption with IPsec ESP using the AES-GCM-128 cipher in IPv6 transport
mode. Packets are encrypted with the key and salt provided to the classes
constructors. These classes do not implement any key exchange protocol.

The encrypt class accepts IPv6 packets and inserts a new [ESP
header](https://en.wikipedia.org/wiki/IPsec#Encapsulating_Security_Payload)
between the outer IPv6 header and the inner protocol header (e.g. TCP,
UDP, L2TPv3) and also encrypts the contents of the inner protocol
header. The decrypt class does the reverse: it decrypts the inner
protocol header and removes the ESP protocol header.

References:

- [IPsec Wikipedia page](https://en.wikipedia.org/wiki/IPsec).
- [RFC 4106](https://tools.ietf.org/html/rfc4106) on using AES-GCM with IPsec ESP.
- [LISP Data-Plane Confidentiality](https://tools.ietf.org/html/draft-ietf-lisp-crypto-02) example of a software layer above these apps that includes key exchange.

— Method **esp_v6_encrypt:new** *config*

— Method **esp_v6_decrypt:new** *config*

Returns a new encryption/decryption context respectively. *Config* must a
be a table with the following keys:

* `mode` - Encryption mode (string). The only accepted value is the
  string `"aes-128-gcm"`.
* `keymat` - Hex string containing 16 bytes of key material as specified
  in RFC 4106.
* `salt` - Hex string containing four bytes of salt as specified in
  RFC 4106.

— Method **esp_v6_encrypt:encapsulate** *packet*

Returns a freshly allocated packet that is the encrypted and encapsulated
version of *packet*. The contents of *packet* are destroyed in the
process.

— Method **esp_v6_decrypt:decapsulate** *packet*

Returns a freshly allocated packet that is the decrypted and decapsulated
version of *packet* or `nil` if authentication failed. The contents of
*packet* are destroyed in the process.
