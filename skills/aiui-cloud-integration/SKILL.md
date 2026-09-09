---
name: "aiui-cloud-integration"
description: "Integrate server-side AIUI agents with Rokid account lookup, one-time message caching, and Rokid Glasses notifications through @yodaos-pkg/cloud-integration or HTTP. Invoke for AIUI cloud credentials, cached messages, notification delivery, or notification-triggered page navigation."
---

# AIUI Cloud Integration

Use this skill for server-side AIUI cloud integrations. Choose the relevant
reference instead of loading every API contract:

- For the official-agent-only account token endpoint or the one-time AIUI
  message cache, read [references/account-services.md](references/account-services.md).
- For Rokid Glasses notification delivery and notification-triggered page
  navigation, read [references/notifications.md](references/notifications.md).

## Package

Install the zero-runtime-dependency package:

```bash
npm install @yodaos-pkg/cloud-integration
```

Import `CloudIntegration` from the package and construct it with the Rokid
account SK. Keep the token in an environment variable or secret manager; do
not put it in AIUI page code, source control, logs, or user-visible data.

```js
import { CloudIntegration } from '@yodaos-pkg/cloud-integration'

const cloud = new CloudIntegration({
  token: process.env.ROKID_SK,
})

await cloud.sendNotification({
  messageId: 'message-unique-id',
  accountId: 'target-account-id',
  message: {
    agentId: 'agent-id',
    content: 'Notification text shown on the Glasses.',
  },
})
```

The account `accessToken` and notification `token` (Rokid account SK) are
different credentials. Keep both server-side in environment variables or a
secret manager. Never copy either into page code, client bundles, source
control, logs, or user-visible errors.

For package signatures and current implementation details, read
[`packages/cloud-integration/README.md`](../../packages/cloud-integration/README.md)
when working in this repository.
