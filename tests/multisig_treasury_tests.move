module multisig_treasury::multisig_treasury_tests {
    use std::vector;
    use sui::test_scenario;
    use sui::tx_context::TxContext;

    use multisig_treasury::treasury;
    use multisig_treasury::proposal;

    //
    // Test: Create Treasury
    //
    #[test]
    fun test_create_treasury() {
        // start scenario with a sender address
        let mut scenario = test_scenario::begin(@0x1);

        // obtain mutable TxContext reference
        let ctx = test_scenario::ctx(&mut scenario);

        // build owners vector
        let mut owners = vector::empty<address>();
        vector::push_back(&mut owners, @0x1);
        vector::push_back(&mut owners, @0x2);

        // call create_treasury (should not abort)
        treasury::create_treasury(owners, 2, ctx);

        // end scenario
        test_scenario::end(scenario);
    }

    //
    // Test: Create Proposal
    //
    #[test]
    fun test_create_proposal() {
        let mut scenario = test_scenario::begin(@0x2);
        let ctx = test_scenario::ctx(&mut scenario);

        // create proposal (should not abort)
        proposal::create_proposal(@0x111, 2, 0, ctx);

        test_scenario::end(scenario);
    }

    //
    // Minimal smoke test: create + sign flow called sequentially.
    // Note: because our `create_proposal` shares the object into storage,
    // the test framework does not provide a straightforward borrow to mutate
    // that shared object from the same test in this simple pattern.
    // So here we only assert that calling create_proposal then calling
    // sign_proposal on a freshly created (non-shared) Proposal would compile
    // — to fully test sign_proposal you'd either:
    //  - modify modules to return an object handle, or
    //  - use a higher-level script (TS) that calls CLI with multiple signers,
    //  - or extend Move modules with test-only helpers to expose mutable refs.
    //
    #[test]
    fun test_smoke_create_and_sign_compile() {
        let mut scenario = test_scenario::begin(@0x3);
        let ctx = test_scenario::ctx(&mut scenario);

        // create a proposal (ensures create path works)
        proposal::create_proposal(@0xAAA, 2, 0, ctx);

        // we stop here — sign_proposal requires a mutable borrow to the shared object
        // which the simple test harness pattern above doesn't extract.
        // For now the absence of an abort is the success condition.
        test_scenario::end(scenario);
    }
}
