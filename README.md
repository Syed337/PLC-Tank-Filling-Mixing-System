# PLC-Tank-Filling-Mixing-System
# PLC-Based Tank Filling, Mixing and Draining System

## 📌 Project Overview

This project implements an automated **tank filling, mixing, and draining system** using PLC programming concepts.

The system is implemented using **Structured Text (ST)** based on the **IEC 61131-3 standard** and is designed to run using **OpenPLC**.

The automation process controls the filling of three tanks to predefined levels. Once all tanks reach their required levels, the system proceeds to the output transfer stage, followed by timed mixing and final draining.

---

## ⚙️ System Operation

The system follows the sequence below:

1. The system starts when the `START` signal is activated.
2. Tank 1 fills until its level reaches **25 units**.
3. Tank 2 fills until its level reaches **20 units**.
4. Tank 3 fills until its level reaches **30 units**.
5. Once all three tanks reach their required levels, the output valve opens.
6. The output valve remains active for a specified duration using a **TON timer**.
7. After the output stage is complete, the mixer starts.
8. The mixer operates for a specified duration using another **TON timer**.
9. After mixing is complete, the drain valve opens.
10. When the final tank becomes empty, the system returns to the idle state.

---

## 🔄 Control Sequence

```text
START
  │
  ▼
Fill Tank 1 → Level = 25
Fill Tank 2 → Level = 20
Fill Tank 3 → Level = 30
  │
  ▼
All Tanks Full
  │
  ▼
Open Output Valve
  │
  ▼
TON Timer
  │
  ▼
Start Mixer
  │
  ▼
TON Timer
  │
  ▼
Open Drain Valve
  │
  ▼
Tank Empty
  │
  ▼
Return to Idle State
