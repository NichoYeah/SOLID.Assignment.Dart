# Core Module

The `core` directory contains application-wide orchestration and UI primitives that are not feature-specific.

Structure:

- `ui/` – Shared application UI and state management for root-level pages or scaffolding.
  - `bloc/` – BLoC classes managing UI state.
  - `pages/` – Top-level pages (e.g., `ShapeCalculationPage`).

Guidelines:

- Domain layer remains pure (`lib/domain`).
- Core may depend on domain interfaces and entities, but not on implementation details outside allowed contracts.
- Future cross-cutting concerns (e.g., theming, routing, error mapping) can live under `core/` (e.g., `core/theme/`, `core/navigation/`).

This separation clarifies that UI orchestration and shared application-level concerns reside in `core`, distinct from domain business logic.
