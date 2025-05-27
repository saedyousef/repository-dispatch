# 🔁 repository-dispatch

A reusable GitHub Action to trigger workflows in another repository using the `repository_dispatch` event.

This action allows you to broadcast custom events (with optional payloads) from one repository to another — ideal for staging deployments, cross-repo coordination, or multi-service automation.

---

## 🚀 Usage

### 🔧 Step 1: Setup the **Target Repository** (Receiver)

In the target repo (e.g., `app-service`), add a workflow like this:

```yaml
# .github/workflows/on-dispatch.yml
name: React to Repository Dispatch

on:
  repository_dispatch:
    types: [example-event]

jobs:
  handle-event:
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "Triggered by: ${{ github.event_name }}"
          echo "Branch: ${{ github.event.client_payload.branch }}"
          echo "Source: ${{ github.event.client_payload.triggered_by }}"
```
### 📤 Step 2: Use in Source Repository (Sender)
```yaml
- name: Trigger dispatch in target repo
  uses: saedyousef/repository-dispatch@v0.1
  with:
    token: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
    owner: your-org
    repo: app-service
    event_type: example-event
    client_payload: '{"key": "value", "key2": "value2"}'
```

> 🔐 token must be a Personal Access Token (PAT) with repo scope (especially for private repos).

## 📥 Inputs

| Name             | Required | Description                                                                    |
|------------------|----------|--------------------------------------------------------------------------------|
| `token`          | ✅        | 🔐 Must be a **Personal Access Token (PAT)** with `repo` scope (private repos) |
| `owner`          | ✅        | Owner of the target repository                                                 |
| `repo`           | ✅        | Name of the target repository                                                  |
| `event_type`     | ✅        | Custom event type to trigger in the target repo                                |
| `client_payload` | ❌        | JSON object as a string with optional data                                     |

---
## 📄 License

This project is licensed under the [MIT License](LICENSE). © 2025 [Saed Yousef](https://github.com/saedyousef)
