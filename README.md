# 🎈 Typing Bubbles — Assembly Language Game

An interactive typing game built entirely in x86 Assembly Language 
and run on DOSBox. Bubbles float upward with letters on them - 
type the correct letter before they escape to pop them and earn points.

## 🛠️ Built With
- **Language:** x86 Assembly (MASM)
- **IDE:** Visual Studio 2022
- **Platform:** DOSBox

## 🎮 Features
- **Real-time keyboard interrupt handling** for responsive input
- **Floating bubbles** displayed with random letters
- **Live score tracking** : 10 points per bubble popped
- **2-minute countdown timer** adding urgency to gameplay
- **Multiple difficulty levels** : Easy and Hard modes
- **Night mode theme** for varied visual experience
- **Pause functionality** available during gameplay
- **Game Over screen** with final score displayed

## 📁 Project Structure
```text
typing-bubbles/
├── start.asm       # ⭐ Main entry point — run this file
├── gameplay.asm    # Core game loop and logic
├── easy.asm        # Easy difficulty settings
├── hard.asm        # Hard difficulty settings
├── diff.asm        # Difficulty selection screen
├── nightgm.asm     # Night mode gameplay
├── gameover.asm    # Game over screen and score display
├── gpause.asm      # Gameplay pause screen
├── ntpause.asm     # Night mode pause screen
└── hlp.asm         # Help screen
```
## 🚀 How to Run
1. Install **DOSBox** on your system
2. Open the project accordingly (e.g Notepad ++ Portable)
3. Download all files
4. Run only start.asm by `Alt + R`
5. The game will launch automatically in DOSBox

## 🕹️ Controls
- All on-screen options are activated by pressing the **highlighted 
  letter** on your keyboard
- For example, when **Help (H)** appears on screen, press `H` on keyboard to open it
- Full gameplay instructions and controls are available in the 
  **in-game Help screen**

## 📚 Concepts Used
- x86 Assembly language programming
- Hardware keyboard interrupt handling
- Real-time input processing and scoring
- Timer implementation in Assembly
- Multi-file modular Assembly programming
- Display and graphics output in Assembly
