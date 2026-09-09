# Rokid Glasses Notifications

Use the Rokid account SK as a Bearer token to send an agent notification to one
Rokid Glasses user. The endpoint is
`POST https://rcs.rokid.com/metis/callback/message`.

With `@yodaos-pkg/cloud-integration`, configure the SK as `token` and call
`sendNotification()` with non-empty `messageId`, `accountId`,
`message.agentId`, and `message.content` values. The SDK converts camelCase to
the HTTP API's `message_id`, `account_id`, and `agent_id` fields.

For page navigation, add `message.tool`. Its `name` must exactly match a route
registered in `app.json`. `parameters.type` must be `"object"`, and
`parameters.properties` must be an object whose values are passed through to
the destination page.

The method resolves with the complete server response only when `code === 1`
and `data.success === true`. Invalid input raises
`CloudIntegrationValidationError`; transport, HTTP, JSON parsing, and business
failures raise `CloudIntegrationError`. Use redacted payload and UUID data for
diagnosis, and never log the SK or Authorization header.

Retry only clearly recoverable network or temporary server failures. Reuse the
same `messageId` for every attempt. Do not retry validation failures or retry
without a bound when the server outcome is unknown.
