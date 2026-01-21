# GitHub Workflow Workshop (Web Only)

## Goal

In this workshop you will practice the **basic GitHub team workflow** using **only the GitHub website** (no command line, no local tools):

- GitHub Project board
- Issues
- Branches
- Commits (editing files in the browser)
- Pull Requests (PRs)
- Reviews
- Merging
- Wiki

By the end, **every team member** should have completed the full workflow and all practice issues should be **Done** on the project board.

---

## Setup

You will work in your **team repository** created via GitHub Classroom.

- Choose one person to create the **Project board** (everyone will use the same board).
- Every student must:
  - Have at least **one Issue** assigned to them.
  - Create a **branch**, make changes, and open a **Pull Request**.
  - Review a teammate’s PR.
  - Help ensure all Issues end up in **Done** on the Project board.

---

## Step 1 – Create a GitHub Project (board)

> One person per team does this.

1. Go to your team repository on GitHub.
2. Click the **Projects** tab.
3. Click **New project**.
4. Choose:
   - Template: **Board**
   - Name: `Team Workflow Practice`
5. Keep the default columns or adjust them (for example):
   - `Todo`
   - `In progress`
   - `Done`
6. Click **Create**.

Everyone on the team will now use this project board.

---

## Step 2 – Create practice Issues and assign them

> The team should create enough issues so that **every member** is assigned at least one.

1. In the repository, click the **Issues** tab.
2. Click **New issue**.
3. Create several issues, such as:
   - `Add team introduction to README`
   - `Add project goals to README`
   - `Describe team roles in README`
   - `Create "Team Workflow" page in Wiki`
   - `Document coding conventions in Wiki`
4. For each issue:
   - Write a short description of what needs to be done.
   - On the right sidebar:
     - **Assignees** → pick *one student*.
     - (Optional) **Labels** → e.g. `documentation`, `wiki`, `readme`.
5. Click **Submit new issue**.

Make sure **no one is left without an assigned issue**.

---

## Step 3 – Add Issues to the Project board

1. Open each issue.
2. On the right sidebar, find **Projects**.
3. Click the **+** or gear next to Projects.
4. Add the issue to the `Team Workflow Practice` project.
5. Check the board:
   - Go to **Projects** → select `Team Workflow Practice`.
   - Confirm that each issue appears as a card (usually in `Todo`).

---

## Step 4 – Move your Issue to “In progress”

Each student:

1. Open the **Project** board (`Team Workflow Practice`).
2. Find the card for your assigned issue.
3. Drag your card from **Todo** to **In progress**.

This shows the team what each person is currently working on.

---

## Step 5 – Create a branch (website only)

Each student creates a branch from the web UI:

1. Go to the **Code** tab of the repository.
2. At the top left, click the branch dropdown (it might say `main`).
3. In the text box, type a new branch name related to your issue, for example:
   - `feature/readme-team-intro`
   - `feature/readme-project-goals`
   - `feature/wiki-team-workflow`
4. Click **Create branch: <your-branch-name> from `main`**.

You now have your own branch on GitHub.

---

## Step 6 – Edit the README in your branch (web editor)

If your issue is about the README:

1. Make sure you’re on **your branch** (check the branch dropdown at the top).
2. In the file list, click **`README.md`**.
3. On the top right of the file view, click the **pencil icon** (Edit this file).
4. Add or edit content according to your issue. For example:

   ```markdown
   ## Team Introduction
   - Alice – Team Lead
   - Bob – Backend Developer
   - Carol – Frontend Developer
   ```

5. Scroll to **Commit changes**:
   - In “Commit message”, write a clear summary, e.g.:
     - `Add team introduction section to README`
   - Ensure **Commit directly to the `<your-branch-name>` branch** is selected.
6. Click **Commit changes**.

You have made a commit on your branch using the browser.

---

## Step 7 – Edit the Wiki (web only)

If your issue is about the Wiki:

1. At the top of the repo, click the **Wiki** tab.
2. Click **Create the first page** (or **New page** if a wiki already exists).
3. Set a **Page title**, for example:
   - `Team Workflow`
4. In the content area, describe a simple team workflow, e.g.:

   ```markdown
   # Team Workflow

   1. Create an issue for each new task.
   2. Create a branch for that issue.
   3. Make and commit changes in the branch.
   4. Open a pull request and get a review.
   5. Merge the pull request and close the issue.
   ```

5. Click **Save page**.

Wiki edits are tracked with your username and timestamp.

---

## Step 8 – Open a Pull Request (PR)

Each student should open at least one PR from their branch into `main`.

1. Go to the **Pull requests** tab.
2. Click **New pull request**.
3. Make sure:
   - **base**: `main`
   - **compare**: your branch (e.g., `feature/readme-team-intro`)
4. Review the changes in the **Files changed** tab.
5. Fill out the PR form:
   - **Title**: clearly describe the change, e.g.:
     - `Add team introduction to README`
   - **Description**:
     - Briefly describe what you changed and why.
     - Link the issue with the keyword:
       - `Closes #<issue-number>`
       - Example: `Closes #3`
6. On the right sidebar:
   - Under **Reviewers**, request at least **one teammate**.
7. Click **Create pull request**.

---

## Step 9 – Review a teammate’s Pull Request

Each student should both **create** a PR and **review** someone else’s PR.

1. Go to the **Pull requests** tab.
2. Open a teammate’s PR.
3. Click **Files changed**.
4. To comment on a specific line:
   - Hover near the line number, click the blue **+** icon.
   - Write a helpful comment or suggestion.
   - Click **Add single comment** or **Start a review**.
5. When you are done reviewing:
   - Click **Review changes** (top right).
   - Choose:
     - **Comment** – general feedback.
     - **Approve** – everything looks good.
     - **Request changes** – something needs to be fixed.
   - Add a short summary and submit the review.

---

## Step 10 – Update your branch if needed

If a reviewer requested changes:

1. Go back to your **branch** on the Code tab.
2. Edit the relevant file(s) again using the web editor (pencil icon).
3. Commit your updates to the **same branch**.
4. The PR will automatically update with your new commits.
5. Ask for a new review if necessary.

---

## Step 11 – Merge the Pull Request

After at least one review and once everyone is satisfied:

1. Go to your PR.
2. Scroll to the bottom.
3. Click **Merge pull request**.
4. Click **Confirm merge**.
5. (Optional but good practice) Click **Delete branch**.

Your changes are now part of the `main` branch.

---

## Step 12 – Close the Issue and move it to “Done”

1. If you used `Closes #<issue-number>` in the PR description, the issue may already be closed automatically.
   - If not, go to the **Issues** tab, open your issue, and click **Close issue**.
2. Open the **Project** board (`Team Workflow Practice`).
3. Find the card that represents your issue.
4. Drag the card from **In progress** to **Done**.

Repeat until **all issues** on the board are moved to **Done**.

---

## Final Checklist – Individual Participation

Each student should be able to say **“Yes”** to all of the following:

- [ ] I have at least one **Issue** assigned to me.
- [ ] I moved my Issue’s card from **Todo** to **In progress** and then to **Done** on the Project board.
- [ ] I created a **branch** using the GitHub website.
- [ ] I edited the **README** or **Wiki** using the web editor.
- [ ] I committed my changes directly to **my branch** on GitHub.
- [ ] I opened at least one **Pull Request** from my branch into `main`.
- [ ] I linked my PR to its Issue using `Closes #<issue-number>`.
- [ ] I requested a **review** from at least one teammate on my PR.
- [ ] I **reviewed** at least one teammate’s PR and submitted a review.
- [ ] I **merged** at least one PR (either my own or as an authorized team member).
- [ ] I verified that my issue is **closed** in the Issues tab.
- [ ] I confirmed that my issue’s card is in the **Done** column on the Project board.

---

## Final Checklist – Team Completion

As a team, verify:

- [ ] Every student appears in the repository’s **Issues**, **Pull requests**, or **Commits** history.
- [ ] Every student is assigned to at least one **Issue**.
- [ ] Every student has at least one **merged Pull Request** (or documented contribution).
- [ ] Every PR is connected to an Issue using `Closes #...` or manually closing the issue.
- [ ] The **Project board** shows:
  - All practice Issues started in **Todo**.
  - Each Issue moved through **In progress**.
  - **All Issues** are finally in **Done**.

When all boxes are checked, your team is ready to start coding together using GitHub’s standard workflow.