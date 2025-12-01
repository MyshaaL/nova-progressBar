# Nova Progress Bar

A modern, sleek progress bar system for FiveM with a clean white design.

Built for **QBX/Qbox** framework.

## Features

- Modern white gradient progress bar with glow effects
- Support for animations during progress
- Cancellable progress with key press
- Control disabling during progress
- Easy export for integration with other resources
- Compatible with QBX/Qbox framework

## Usage

```lua
local success = exports['nova-progressBar']:ShowProgress(duration, label, options)
```

**Parameters:**
- `duration` (number): Duration in milliseconds
- `label` (string): Text displayed above the progress bar
- `options` (table, optional):
  - `canCancel` (boolean): Allow cancellation with X key (default: false)
  - `animation` (table): Animation settings (dict, anim, flags)
  - `disableControls` (table): Array of control IDs to disable

**Returns:** `boolean` - `true` if completed, `false` if cancelled

## Examples

```lua
-- Simple progress bar
exports['nova-progressBar']:ShowProgress(5000, 'Loading...', {})

-- With cancel option
exports['nova-progressBar']:ShowProgress(8000, 'Collecting...', {
    canCancel = true
})

-- With animation
exports['nova-progressBar']:ShowProgress(6000, 'Repairing...', {
    canCancel = true,
    animation = { dict = 'mini@repair', anim = 'fixing_a_player' }
})
```

## Installation

Add `ensure nova-progressBar` to your `server.cfg`

---
**Nova Studio** © 2025
