# Mermaid

## Syntax

### Basics

- Comment: `%%`
- Diagram Type:
  - Flowchart: `graph <DIRECTION>`
    - `TD` (Top to Down)
    - `LR` (Left to Right)
  - Sequence Diagram: `sequenceDiagram`
  - Gantt Chart: `gantt`
- Link and Arrows:
  - `-->`: Standard arrow
  - `<-->`: Bi-direction arrow
  - `-.->`: Dotted line
  - `==>`: Think line
  - `---`: Open link

### Node Shapes (table made by Gemini)

| Shape                   | Syntax                   | Appearance                               | Common Use Case                           |
| :---------------------- | :----------------------- | :--------------------------------------- | :---------------------------------------- |
| **Rectangle**           | `[Text]`                 | A standard box.                          | General process steps, tasks, or actions. |
| **Rounded Rectangle**   | `(Text)`                 | A box with rounded corners.              | Events or start/end points.               |
| **Circle**              | `((Text))`               | A perfect circle.                        | Start or end point of a process.          |
| **Rhombus (Diamond)**   | `{Text}`                 | A diamond or rhombus shape.              | **Decision points**.                      |
| **Asymmetric (Flag)**   | `>Text]`                 | A box with one side cut off at an angle. | Terminal or output points.                |
| **Hexagon**             | `{{Text}}`               | A six-sided polygon.                     | Initial or final points.                  |
| **Cylinder (Database)** | `[(Text)]`               | A cylindrical shape.                     | **Database** or data storage.             |
| **Subroutine**          | `[[Text]]`               | A rectangle with vertical lines.         | A predefined process or subroutine.       |
| **Trapeze**             | `[\Text\]` or `[/Text/]` | A trapezoid.                             | Manual operations or input/output.        |

## Exercises

### Flowchart

```mermaid
graph LR

    A[Start] --> B{Is it raining?};
    B -- Yes --> C[Take an umbrella];
    C --> D[Go outside];
    B -- No --> D;
    D --> E[End];
```

### Sequence Diagram

```mermaid
sequenceDiagram

    participant User
    participant Browser
    participant Server

    User->>Browser: Requests page
    activate Browser
    Browser->>Server: HTTP GET request
    activate Server
    Server-->>Browser: Sends HTML
    deactivate Server
    Browser-->>User: Displays page
    deactivate Browser
```

### Gantt Chart

```mermaid
gantt

  %% Configs
  title POC Timeline
  dateformat YYYY-MM-DD
  axisFormat %m/%d
  tickInterval 1week
  excludes weekends

  %% Feature 1
  section Feature 1
  Data Collection: done, a1, 2025-08-25, 1w
  Model Training/Testing: active, a2, after a1, 2w
  Module Optimization: after a2, 1w

  %% Feature 2
  section Feature 2
  Data Collection/Cleaning: active,b1, 2025-08-25, 2w
  Model Finetuning: b2, after b1, 1w
  Module Optimization: after b2, 1w

  %% Platform
  section Platform
  Customization: active, c1, 2025-08-25, 4w
  Integration: active, d1, 2025-09-01, 1w
```
