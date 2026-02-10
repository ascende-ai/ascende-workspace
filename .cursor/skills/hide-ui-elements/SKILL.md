---
name: hide-ui-elements
description: Safely hide UI elements in PearAI without breaking functionality. Use when refactoring UI visibility, hiding features, or implementing feature flags for React components with Tailwind CSS.
---

# Hide UI Elements Safely

Guide for safely hiding UI elements in the PearAI codebase without breaking existing functionality.

## Project Context

PearAI uses:
- **React** with TypeScript
- **Tailwind CSS** for styling
- **shadcn/ui** components with CVA (class-variance-authority)
- **Redux** for state management
- **Vite** dev server for GUI components

## When to Use This Skill

Use this skill when:
- Hiding UI elements temporarily during refactoring
- Implementing feature flags for gradual rollouts
- Testing UI changes without removing code
- Conditionally showing/hiding components based on state

## Decision Tree: How to Hide

### 1. **Conditional Rendering** (Safest for complete removal)

```typescript
// Simple condition
{!shouldHide && <Component />}

// With feature flag
const { showFeature } = useFeatureFlags();
if (!showFeature) return null;
```

**Use when:**
- Component doesn't need to exist in DOM
- No other components depend on its refs or measurements
- No side effects (useEffect) that other code expects
- Performance is a concern (component won't mount)

**Pros:** Component not mounted, best performance, cleanest
**Cons:** Loses state if toggled, side effects don't run

### 2. **Tailwind Conditional Classes** (Recommended for quick changes)

```typescript
import { cn } from "@/lib/utils";

<div className={cn(
  "base-component-classes",
  shouldHide && "hidden" // or "invisible" to keep space
)}>
  {/* content */}
</div>
```

**Use when:**
- Need element in DOM for refs/measurements
- Quick reversible changes
- Testing different layouts
- Parent depends on child dimensions

**Pros:** Fast, reversible, keeps element in DOM, works with existing Tailwind setup
**Cons:** Element still rendered (uses memory), styles still computed

### 3. **CVA Variants** (Best for reusable components)

```typescript
import { cva, type VariantProps } from "class-variance-authority";

const componentVariants = cva("base-classes", {
  variants: {
    visibility: {
      visible: "",
      hidden: "hidden",
      invisible: "invisible", // keeps space
    }
  },
  defaultVariants: {
    visibility: "visible"
  }
});

interface ComponentProps extends VariantProps<typeof componentVariants> {
  // ... other props
}

export function Component({ visibility, ...props }: ComponentProps) {
  return (
    <div className={componentVariants({ visibility })}>
      {/* content */}
    </div>
  );
}
```

**Use when:**
- Building or refactoring shadcn/ui-style components
- Need type-safe visibility control
- Component will be reused with different visibility states
- Following project's component architecture

**Pros:** Type-safe, reusable, follows shadcn/ui patterns, scales well
**Cons:** More initial setup, requires component refactoring

### 4. **Redux Feature Flags** (Architecture-level control)

```typescript
// In redux/slices/uiStateSlice.ts
interface UIState {
  hiddenFeatures: {
    tutorialCard: boolean;
    statusBar: boolean;
    welcomeModal: boolean;
  };
}

// In component
import { useSelector } from 'react-redux';

const hideTutorialCard = useSelector(
  (state: RootState) => state.uiState.hiddenFeatures.tutorialCard
);

return !hideTutorialCard && <TutorialCard />;
```

**Use when:**
- Multiple components need the same visibility state
- Implementing user preferences
- A/B testing features
- Need persistence across sessions
- Coordinating visibility across app

**Pros:** Centralized, persistent, testable, works across components
**Cons:** More boilerplate, requires Redux setup

## Safety Checklist

Before hiding ANY element, verify:

- [ ] **No refs dependencies**: Other components don't use `useRef()` to access this element
- [ ] **No dimension measurements**: Parent doesn't call `getBoundingClientRect()` or similar
- [ ] **No required side effects**: `useEffect` hooks aren't critical for other components
- [ ] **Form validation safe**: If in a form, validation doesn't break
- [ ] **Event listeners clean**: No orphaned event listeners expected
- [ ] **CSS layout intact**: Removing doesn't break Flexbox/Grid parent layout
- [ ] **Accessibility maintained**: Screen readers have alternative navigation

## What NOT to Do

### ❌ Inline styles (breaks theme system)
```typescript
<div style={{ display: 'none' }}>  // DON'T
```

### ❌ Custom CSS when Tailwind exists
```css
.my-hidden { display: none; }  /* Redundant */
```

### ❌ Commenting JSX long-term
```typescript
{/* <Component /> */}  // Temporary OK, but not for production
```

### ❌ Empty divs as placeholders
```typescript
{shouldHide ? <div /> : <Component />}  // Just use conditional
```

## Testing Strategy

After hiding elements:

1. **Visual Test**: Open the app, navigate to affected areas
2. **Console Check**: Look for React errors or warnings
3. **User Flow Test**: Complete workflows that involve the hidden element
4. **Redux DevTools**: Verify state changes work correctly
5. **Network Tab**: Ensure API calls still fire as expected
6. **Performance**: Check React DevTools Profiler for unexpected renders

## Common Patterns in PearAI

### Hiding Tutorial/Onboarding
```typescript
// src/components/mainInput/TutorialCard.tsx
import { useFeatureFlags } from "@/hooks/useFeatureFlags";

export function TutorialCard() {
  const { showTutorialCard } = useFeatureFlags();
  
  if (!showTutorialCard) return null;
  
  return <div>Tutorial content</div>;
}
```

### Hiding Settings Section
```typescript
// src/pages/inventory.tsx
<SettingsSection
  className={cn(hideBetaFeatures && "hidden")}
>
  {/* content */}
</SettingsSection>
```

### Hiding Model Provider Options
```typescript
// src/components/modelSelection/ModelSelect.tsx
const filteredProviders = providers.filter(
  provider => !hiddenProviders.includes(provider.id)
);
```

## Quick Reference Hook

Create a centralized hook for all UI visibility flags:

```typescript
// src/hooks/useUIVisibility.ts
export const useUIVisibility = () => {
  // Can integrate with Redux, localStorage, or useState
  return {
    showTutorialCard: true,
    showWelcomeModal: false,
    showBetaFeatures: true,
    showDeprecatedOptions: false,
  };
};
```

## File Locations

- GUI Components: `pearai-submodule/gui/src/components/`
- Pages: `pearai-submodule/gui/src/pages/`
- Redux State: `pearai-submodule/gui/src/redux/slices/`
- Hooks: `pearai-submodule/gui/src/hooks/`
- Tailwind Config: `pearai-submodule/gui/tailwind.config.cjs`

## Getting Help

If uncertain about the impact of hiding an element:

1. Search codebase for the component name to find dependencies
2. Check Redux state to see if visibility affects other features
3. Look for `useRef` or `getBoundingClientRect` in parent components
4. Run `npm run watch` and test thoroughly
5. Invoke the `/verify-ui-changes` subagent after changes

## Examples

See the patterns used in:
- `src/components/modelSelection/` - Model provider filtering
- `src/pages/onboarding/` - Conditional tutorial steps
- `src/components/mainInput/` - Context menu visibility
- `src/inventory/pearSettings/` - Settings sections

## Remember

- **Quick & dirty**: Use `hidden` Tailwind class
- **Production-ready**: Use conditional rendering with feature flags
- **Component architecture**: Use CVA variants
- **App-wide coordination**: Use Redux state

Always test in the dev environment (`npm run dev` in gui folder) before considering changes final.
