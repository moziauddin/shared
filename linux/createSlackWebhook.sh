# Create a webhoot by logging into slack web and following the below steps
     # 1. Create a new Slack app in the workspace where you want to post messages.
     # 2. From the Features page, toggle Activate incoming webhooks on.
     # 3. Click Add new webhook to workspace.
     # 4. Pick a channel that the app will post to, then click Authorise.
     # 5. Use your incoming webhook URL to post a message to Slack.

# Example: Create Slack Webhook to print WAN IP to a channel
PUBLIC_IP=$(curl -s http://ipinfo.io/ip);
H_NAME=$(hostname);
curl -s -X POST \
     --data-urlencode "payload={\"channel\": \"#dev-ag-bie\", \"username\": \"webhookbot\", \"text\": \" The public ip address of *${H_NAME}* is *${PUBLIC_IP}*\", \"icon_emoji\": \":ghost:\"}" \
https://hooks.slack.com/**URL**