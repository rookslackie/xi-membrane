# Handoff update: native verification first

The updated upstream reference suite passed all 9 tests after restoring its sample-capsule.txt to its exact Git blob bytes. Windows Git autocrlf had expanded its LF to CRLF (49 instead of 48 bytes). Consider `.gitattributes` with `examples/sample-capsule.txt -text` to preserve this binary-sensitive fixture on every checkout. Our control fixture also passed the updated reference receiver: identical replay executed once, and changed capsule bytes were rejected.

Both upstream corrections are present in the updated bridge checkout recorded in source-manifest.json. This package follows its base64 preference. The original legacy-exchange.json and fabric-capsule.json source bytes have not been regenerated.

## File map

- README.md: observed implementation and distinctions.
- legacy-exchange.json: synthetic historical Vessel exchange format.
- fabric-capsule.json: synthetic XiFabric.v1 capsule.
- native-bridge-capsule.json: exact fabric-capsule.json bytes, base64 wrapped.
- native-bridge-request.json: proposed forgecore.fabric.verify request to ForgeCore.
- native-bridge-expected-result.json and native-bridge-expected-receipt.json: expected bridge return and separate receipt.
- fabric-verify-request.json and fabric-verify-result.json: native HTTP input and live observed response.
- bridge-capsule.json, bridge-request.json, bridge-expected-result.json, bridge-expected-receipt.json: artifact.sha256 control over exact legacy packet bytes.
- proposed-aliases.json: both proposed aliases with method/path mappings.
- proposed-capability.json: native verify advertisement in bridge schema form.
- source-manifest.json: inspected implementation fingerprints and pinned upstream commits.
- SHA256SUMS: SHA-256 of each packaged file except itself.
- verify_fixtures.py: dependency-free checker. Run `python verify_fixtures.py` without `-O` (it uses assertions).

## Exact bytes

Read original files in binary mode. Base64-decode content.data with strict validation; compare decoded byte length and SHA-256 before parsing any JSON. Do not change line endings, trailing newline, escaping, key order, whitespace or Unicode normalization. File hashes cover exact original bytes including their final newline. These hashes are distinct from the native compact-canonical JSON integrity hashes described in README.md.

For native verification, parse the preserved XiFabric bytes only after verifying the outer content hash. Require request.payload.input.capsule to match that parsed offered capsule, then pass `{capsule: ...}` to the native route. Reject mismatched inline input and offered content. Re-encoding the HTTP request body is fine: native verification computes its own canonical digests from the parsed object; the separately preserved artifact bytes must remain unchanged.

In the proposed receipt, artifact_sha256 refers to the exact offered input capsule bytes, not the verification response JSON. The bridge schemas do not currently define a result digest field. All expected receipt timestamps are fixture values; an actual bridge generates its own RFC 3339 recorded_at and should compare semantic fields rather than require byte equality to a fixture timestamp.

The native verify operation does not store a capsule. An adapter's receipt/idempotency store is separate. Neither proposed alias is installed as a public bridge dispatcher by this handoff. No remote credentials, authentication setup or cross-system execution is claimed.
