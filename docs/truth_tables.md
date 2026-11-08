# Task 2 truth and next-state tables

The following tables describe the sequential RTL behavior. A plus sign in `Q+` means the value after the specified event.

## D flip-flop

For a synchronous reset, reset is sampled only at the rising clock edge.

| Rising clock edge? | Reset | D | Q+ |
|---|---:|---:|---:|
| Yes | 1 | X | 0 |
| Yes | 0 | 0 | 0 |
| Yes | 0 | 1 | 1 |
| No | 0 | X | Q (hold) |

For an asynchronous reset, asserting reset clears Q immediately, even without a clock edge. When reset is inactive, D is captured on the rising edge.

| Event | Reset | D | Q+ |
|---|---:|---:|---:|
| Reset asserted | 1 | X | 0 immediately |
| Rising clock edge | 0 | 0 | 0 |
| Rising clock edge | 0 | 1 | 1 |
| No active event | 0 | X | Q (hold) |

## Register and shift register

| Block | Reset | Clock event | Input | Next output |
|---|---:|---|---|---|
| Register | 1 | Rising edge | Any `data_in` | `data_out = 0` |
| Register | 0 | Rising edge | `data_in` | `data_out = data_in` |
| Register | 0 | No rising edge | Any | Hold |
| Shift register | 1 | Rising edge | Any `serial_in` | `data_out = 0` |
| Shift register | 0 | Rising edge | `serial_in` | `data_out = (data_out << 1) | serial_in` |
| Shift register | 0 | No rising edge | Any | Hold |

The synchronous and asynchronous variants behave the same on clock edges; the asynchronous versions also clear immediately when reset is asserted.

## Parameterized counter control

| Reset | Enable | Direction | Next count |
|---:|---:|---:|---|
| 1 | X | X | 0 |
| 0 | 0 | X | Hold current count |
| 0 | 1 | 1 | `count + 1` modulo `2^WIDTH` |
| 0 | 1 | 0 | `count - 1` modulo `2^WIDTH` |

## Traffic-light FSM outputs and transitions

The Moore outputs depend only on the current state. A tick advances the state; without a tick, the controller holds its state.

| Current state | Red | Yellow | Green | Next state when tick = 0 | Next state when tick = 1 |
|---|---:|---:|---:|---|---|
| RED | 1 | 0 | 0 | RED | GREEN |
| GREEN | 0 | 0 | 1 | GREEN | YELLOW |
| YELLOW | 0 | 1 | 0 | YELLOW | RED |

For the Mealy traffic-light example, the emergency input overrides the color outputs immediately:

| Emergency | State | Red | Yellow | Green |
|---:|---|---:|---:|---:|
| 1 | Any | 1 | 0 | 0 |
| 0 | RED | 1 | 0 | 0 |
| 0 | GREEN | 0 | 0 | 1 |
| 0 | YELLOW | 0 | 1 | 0 |

These tables correspond to `rtl/sequential.v`, `rtl/parameterized.v`, and `rtl/fsm_controllers.v`.
