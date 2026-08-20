---
name: Dio Technology Enforcer
description: Regulates the usage of Dio, caching layers, and authorization interceptors.
---

# Dio Technology Enforcer

## Purpose
Ensures that all network communication is handled securely, efficiently, and within the constraints of the data layer.

## Scope
Dio client providers, interceptors, and DataSource request handling.

## Dependencies
### Required
- `_core/architecture`

## Rules
1. **network client Provider**:
   - Access the single, shared Dio instance via the global `dioProvider`.
2. **Authorization Interceptor**:
   - All network requests automatically append the `Authorization: Bearer <token>` header (via `AuthInterceptor`).
   - Handles auto-retry on connection timeouts and server issues up to 15 times with a 2-second delay.
3. **Response Caching**:
   - Employs `DioCacheInterceptor` using `MemCacheStore` to cache responses, except on authorization errors (401, 403).

## Forbidden
- **UI Widgets / Controllers** ❌ MUST NOT import Dio or execute HTTP requests directly.
- **Dio requests** ❌ MUST NOT bypass the global `AuthInterceptor` configuration.

## Workflow
1. Declare Dio endpoint requests inside concrete DataSources.
2. Rely on `AuthInterceptor` to attach headers and manage connection retries.

## Verification
- Verify network connection responses during testing.
