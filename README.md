# Upgradeable Contract Testing with OpenZeppelin Foundry Upgrades

This repository demonstrates and tests the upgrade flow for smart contracts using OpenZeppelin's Foundry Upgrades plugin with **transparent upgradeable proxies**.

## Overview

This project serves as a testing ground for OpenZeppelin's upgradeable contract patterns, specifically focusing on:

- **Transparent Upgradeable Proxy Pattern**: Using OpenZeppelin's `TransparentUpgradeableProxy` for upgradeable contracts
- **OpenZeppelin Foundry Upgrades Plugin**: Leveraging the `openzeppelin-foundry-upgrades` library for seamless deployment and upgrade workflows
- **FFI (Foreign Function Interface)**: The plugin uses FFI to communicate with OpenZeppelin's validation and deployment tools
- **Upgrade Safety**: Testing storage layout compatibility and upgrade validation

## Architecture

### Contract Structure

- **CounterV1**: Initial implementation with basic counter functionality

  - Uses `Initializable` from OpenZeppelin for upgrade-safe initialization
  - Includes `increment()` and `setNumber()` functions
  - Constructor is disabled with `_disableInitializers()`

- **CounterV2**: Upgraded implementation extending CounterV1
  - Adds `decrement()` functionality
  - Uses `@custom:oz-upgrades-from CounterV1` annotation for upgrade validation
  - Maintains storage layout compatibility

### Proxy Pattern

We use the **Transparent Upgradeable Proxy** pattern which consists of:

- **Implementation Contract**: Contains the actual logic (CounterV1, CounterV2)
- **Proxy Contract**: Delegates calls to the implementation while maintaining state
- **ProxyAdmin**: Manages the proxy and controls upgrades

## Testing Strategy

### Deployment Tests (`CounterDeploy.t.sol`)

- Tests initial deployment using `Upgrades.deployTransparentProxy()`
- Verifies proxy deployment and initialization
- Tests basic functionality of the deployed contract

### Upgrade Tests (`CounterUpgrade.t.sol`)

- Tests the complete upgrade flow from V1 to V2
- Manually deploys proxy for testing control
- Uses `Upgrades.upgradeProxy()` to perform the upgrade
- Verifies state preservation and new functionality

## OpenZeppelin Plugin Role

The `openzeppelin-foundry-upgrades` plugin provides several key capabilities:

### FFI Integration

- **Validation**: Uses FFI to call OpenZeppelin's validation tools that check:
  - Storage layout compatibility between versions
  - Constructor safety
  - Initializer patterns
  - Upgrade safety annotations

### Deployment Automation

- **Proxy Creation**: Automatically creates and configures transparent proxies
- **Implementation Management**: Handles implementation contract deployment
- **Admin Setup**: Configures ProxyAdmin with proper ownership

### Upgrade Management

- **Version Validation**: Ensures upgrade compatibility through FFI validation
- **Safe Upgrades**: Performs storage layout checks before allowing upgrades
- **Error Handling**: Provides clear error messages for upgrade failures

## Usage

### Prerequisites

```bash
forge install
```

### Build

```bash
forge build
```

### Run Tests

```bash
# Run deployment tests
forge test --match-test testIncrementV1

# Run upgrade tests
forge test --match-test testUpgradeToV2

# Run all tests
forge test
```

### Deploy to Network

```bash
# Deploy initial contract
forge script script/DeployCounter.s.sol:DeployCounter --rpc-url <your_rpc_url> --private-key <your_private_key>

# Upgrade existing contract (set COUNTER_PROXY in .env)
forge script script/UpgradeCounter.s.sol:UpgradeCounter --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Format and Lint

```bash
forge fmt
```

## Key Features Demonstrated

1. **Upgrade-Safe Initialization**: Using `Initializable` instead of constructors
2. **Storage Layout Preservation**: Maintaining compatibility between versions
3. **Upgrade Validation**: Automatic checks for upgrade safety
4. **Proxy Management**: Transparent proxy deployment and administration
5. **FFI Integration**: Seamless communication with OpenZeppelin's validation tools

## Dependencies

- **forge-std**: Foundry testing framework
- **openzeppelin-foundry-upgrades**: Upgrade management plugin
- **openzeppelin-contracts-upgradeable**: Upgradeable contract base classes

## Learn More

- [OpenZeppelin Upgrades Documentation](https://docs.openzeppelin.com/upgrades-plugins/1.x/)
- [Foundry Book](https://book.getfoundry.sh/)
- [Transparent Proxy Pattern](https://docs.openzeppelin.com/contracts/4.x/api/proxy#TransparentUpgradeableProxy)
