---
marp: true
theme: default
title: Presentation
author: Kuan-Hsien Wu
header: K.H. Wu
_header: ''
footer: Generated with Marp
_footer: ''
paginate: true
_paginate: false
style: custom-style.css
---

<script type="module">
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: true });
</script>

---

Test

---

<pre class="mermaid">

graph LR;
  A --> B;

</pre>

---

# 分栏示例

<div class="column">
- 第一列内容
- 第一列内容
</div>

<div class="column">
- 第二列内容
- 第二列内容
</div>

---

<div class="multicolumn">
这是一个多列文本示例。文本将自动分成三列显示。
</div>

---

# 浮动元素示例

<div class="float-left">
- 左侧浮动内容
- 左侧浮动内容
</div>

<div class="float-right">
- 右侧浮动内容
- 右侧浮动内容
</div>

---

# 网格布局示例

<div class="grid-container">
    <div class="grid-item">第一项</div>
    <div class="grid-item">第二项</div>
    <div class="grid-item">第三项</div>
</div>

---

# Portfolio Gallery

<div class="gallery">
  <div><img src="https://via.placeholder.com/400x200?text=UX+Design"><span>UX Design Review</span></div>
  <div><img src="https://via.placeholder.com/400x200?text=User+Flow"><span>Revised User Flow</span></div>
  <div><img src="https://via.placeholder.com/400x200?text=Prototype"><span>Interactive Prototype</span></div>
  <div><img src="https://via.placeholder.com/400x200?text=Launch"><span>GTM Strategy</span></div>
</div>

---

# Strategic Pillars

<div class="grid-2">
  <div class="card">
    <strong>Security</strong><br>
    <small>Enterprise-grade encryption and SOC2 compliance.</small>
  </div>
  <div class="card" style="border-left-color: #34a853;">
    <strong>Scalability</strong><br>
    <small>Auto-scaling clusters across 12 global regions.</small>
  </div>
</div>

---

# Reference

- https://www.cnblogs.com/lizhuo6/p/18609353
- https://www.cnblogs.com/luyi07/p/14823541.html
- https://ivonblog.com/posts/vscode-marp-presentation/

---

# 4. Split Layout (Text + Image)

Writing on the left side...

![bg right:40% 80%](https://images.unsplash.com/photo-1451187580459-43490279c0fa)

*The directive above `bg right:40%` automatically splits the screen.*

---

# 5. Full Background Images

![bg brightness:0.5](https://images.unsplash.com/photo-1451187580459-43490279c0fa)

# **High Contrast Title**

### Background images can be filtered (blur, brightness, etc.)

---

# 1. The Title Slide

## Subtitle or Author Name

### 2026 Edition

---

# 2. Basic Text & Formatting

This is a standard paragraph. You can use **bold**, *italics*, or ~~strikethrough~~ easily.

> "This is a blockquote for highlighting important statements or testimonials."

---

# 3. Lists (Bullets & Numbers)

**Key Features:**

- Item one
- Item two
  - Sub-item (indented)
- Item three

**Steps to Success:**

1. Plan the content
2. Write the Markdown
3. Export to PDF/PPTX

---

# 6. Tables & Data

| Feature         |  Marp   | PowerPoint  |
| :-------------- | :-----: | :---------: |
| Speed           | ⚡ Fast |   🐢 Slow   |
| Version Control | ✅ Yes  |    ❌ No    |
| Alignment Pain  | ❌ None | 📈 Infinite |

---

# 7. Code & Math

Useful for technical presentations.

```python
def hello_marp():
    print("Goodbye, manual formatting!")
```

---

# 8. Layout: Text + Text (Two Columns)

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
<div>

### Column A

- Focus on the **Why**
- Data-driven insights
- Customer feedback loops

</div>
<div>

### Column B

- Focus on the **How**
- Rapid prototyping
- Agile deployment cycles

</div>
</div>

---

# 9. Layout: Image with Caption

<p align="center">
  <img src="https://images.unsplash.com/photo-1451187580459-43490279c0fa" width="50%" height="50%" />
  <br>
  <em>Figure 1: This is a centered caption using italicized text.</em>
</p>

---

# 98%

### Customer Satisfaction Rate in 2026

*Surpassing all previous industry benchmarks*

---

# Core Strategic Pillars

<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 30px; text-align: center;">
<div>

### 🛡️ Security

Built-in encryption at every layer of the stack.

</div>
<div>

### ⚡ Speed

Sub-100ms latency for global users.

</div>
<div>

### 📈 Scale

Elastic infrastructure that grows with you.

</div>
</div>

---

# Legacy vs. Modern Workflow

<div style="display: grid; grid-template-columns: 1fr auto 1fr; gap: 20px; align-items: center;">
<div style="background: #fee; padding: 20px; border-radius: 10px;">

### The Old Way

- Manual data entry
- Fragile Excel sheets
- Email-based approvals

</div>

<div style="font-size: 2em; font-weight: bold;"> VS </div>

<div style="background: #efe; padding: 20px; border-radius: 10px;">

### The New Way

- Automated API sync
- Real-time Dashboards
- Slack integrations

</div>
</div>

---

# Stakeholder Feedback

<div style="display: flex; align-items: center; gap: 40px; margin-top: 50px;">
  <img src="https://i.pravatar.cc/200" style="border-radius: 50%; border: 5px solid #1a73e8;" />
  <blockquote style="border: none; font-size: 1.2em;">
    "The transition to Marp has reduced our deck creation time by 60%. It's the most efficient tool we've adopted this year."
    <br><br>
    <strong>— Sarah Chen</strong><br>Head of Design
  </blockquote>
</div>

---

# Design Explorations

<div style="display: grid; grid-template-columns: 1fr 1fr; grid-template-rows: 1fr 1fr; gap: 10px;">
  <img src="https://via.placeholder.com/400x200?text=Mobile+UI" style="width:100%; height:200px; object-fit:cover;">
  <img src="https://via.placeholder.com/400x200?text=Desktop+UI" style="width:100%; height:200px; object-fit:cover;">
  <img src="https://via.placeholder.com/400x200?text=Dark+Mode" style="width:100%; height:200px; object-fit:cover;">
  <img src="https://via.placeholder.com/400x200?text=Accessibility" style="width:100%; height:200px; object-fit:cover;">
</div>

---

# Portfolio Highlights

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; row-gap: 40px;">

<div style="text-align: center;">
    <img src="https://via.placeholder.com/400x250?text=Mobile+App" style="width:100%; border-radius: 8px;">
    <div style="font-size: 0.6em; margin-top: 10px; color: #555;"><strong>Project A:</strong> iOS Redesign</div>
  </div>

<div style="text-align: center;">
    <img src="https://via.placeholder.com/400x250?text=Dashboard" style="width:100%; border-radius: 8px;">
    <div style="font-size: 0.6em; margin-top: 10px; color: #555;"><strong>Project B:</strong> Analytics Dashboard</div>
  </div>

<div style="text-align: center;">
    <img src="https://via.placeholder.com/400x250?text=Branding" style="width:100%; border-radius: 8px;">
    <div style="font-size: 0.6em; margin-top: 10px; color: #555;"><strong>Project C:</strong> Identity & Logo</div>
  </div>

<div style="text-align: center;">
    <img src="https://via.placeholder.com/400x250?text=Marketing" style="width:100%; border-radius: 8px;">
    <div style="font-size: 0.6em; margin-top: 10px; color: #555;"><strong>Project D:</strong> Ad Campaign</div>
  </div>

</div>
