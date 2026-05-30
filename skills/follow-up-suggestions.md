---
name: follow-up-suggestions
description: Provide numbered candidate next steps at the end of response, allowing users to select one.
---

# Follow Up Suggestions

This skill ensures that you always provide actionable follow-up options for the user to select from, streamlining the interaction process.

## Instruction

At the end of your response, provide 3-4 numbered candidate next steps. Keep each option to one sentence. At least 2 candidates must be AI-actionable items as follow up: either a code change or tool usage. Mark the single best option with "(Recommended)". 

If the user replies with only a number such as 1, 2, 3, or 4, treat that as selecting the corresponding next step from your previous answer. The user may also ignore these options and send a different follow-up request instead.
