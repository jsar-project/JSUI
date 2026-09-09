# AIUI Account Services

These server endpoints use an account-center credential in the `access_token`
header. They are not AIUI-side OpenAPI methods. With the npm package, configure
`accessToken` and an explicit `aiuiEndpoint`; the contract does not specify a
universal AIUI host.

## Get the account token

`getToken` is available only to system agents:

```js
const cloud = new CloudIntegration({
  accessToken: process.env.ACCOUNT_ACCESS_TOKEN,
  aiuiEndpoint: process.env.AIUI_ENDPOINT,
})

const value = await cloud.getToken()
```

The HTTP form is `GET /account/v1/token` with the `access_token` header. A
successful response has a string schema. Treat the body as opaque; do not
invent JSON fields. Invalid authentication returns `401`.

## Cache an AIUI message

```js
await cloud.saveTemporaryMessage('agent-id', '/pages/agent/message', {
  customData: 'custom-data',
  content: 'You have a new agent message.',
})
```

The HTTP form is `POST /metis/openApi/v1/cacheAIUIMessage`, with
`Content-Type: application/json` and `access_token`. The SDK maps
`targetAgentId` to the HTTP body's `agentId`; `targetAgentId`, `path`,
`data.customData`, and `data.content` are required non-empty strings.
Authentication determines the account; never add `accountId` or `access_token`
to the JSON body.

The cache is isolated by authenticated account ID and `agentId`, expires after
10 minutes, and replaces an earlier value for the same pair. It is not a
queue. `getAIUICacheMessage` atomically consumes and deletes the value, so do
not design for repeated reads.

The common response contains numeric `code`, string `msg`, millisecond
`timestamp`, request `uuid`, and object `data`. Only `code === 1` is success.
Validate `path`, `customData`, and `content` before using them for navigation or
rendering. Redact credentials and sensitive payloads from diagnostics.
