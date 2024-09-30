# Test Cases

## Unit Tests

### UserRepository Tests
- **Test Case 1**: Verify that `getUserData` returns correct user data.
- **Test Case 2**: Verify that `addBeneficiary` adds a new beneficiary correctly.
- **Test Case 3**: Verify that `topUp` performs a top-up correctly.

### TopUpCubit Tests
- **Test Case 1**: Verify that `initializeUser` initializes the user correctly.
- **Test Case 2**: Verify that `addBeneficiary` emits the correct state when a beneficiary is added successfully.
- **Test Case 3**: Verify that `topUp` emits the correct state when a top-up is performed successfully.
- **Test Case 4**: Verify that `getTransactionsForBeneficiary` returns the correct transactions for a given beneficiary.

## Widget Tests

### Add Beneficiary Page Test
- **Test Case 1**: Verify that the form displays validation errors when fields are empty.
- **Test Case 2**: Verify that a success message is shown when a beneficiary is added successfully.
- **Test Case 3**: Verify that an error message is shown when the maximum number of beneficiaries is reached.

## Integration Tests

### App Initialization Test
- **Test Case 1**: Verify that the app starts and displays the home screen.
- **Test Case 2**: Verify that navigating to the add beneficiary page works correctly.
- **Test Case 3**: Verify that adding a beneficiary and performing a top-up works end-to-end.
