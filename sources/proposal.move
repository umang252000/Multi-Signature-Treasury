module 0x0::proposal {
    // Corrected Imports:
    // 1. Removed duplicate/unnecessary aliases.
    // 2. Changed ID to UID for Sui object declaration.
    use std::vector;
    use sui::object::{UID}; // Use UID for object struct definition
    use sui::tx_context::{Self as tx_context, TxContext}; // Use Self as alias for module functions
    use sui::transfer; // Required for transferring the created Proposal object

    // E01003 Fix: The struct must be declared 'public' in Move 2024.
    public struct Proposal has key {
        // Sui E02007 Fix: The first field of a 'key' struct must be 'id: UID'.
        id: UID, 
        creator: address,
        signatures: vector<address>,
        threshold: u8,
        executed: bool,
        time_lock_end: u64, // epoch secs when executable
        // include a placeholder for transactions
    }

    // Sui E02002 Fix: Removed 'entry' keyword and added transfer.
    // Resource-returning functions cannot be 'entry' unless the resource has 'drop'.
    public fun create_proposal(
        creator: address,
        threshold: u8,
        time_lock_end: u64,
        ctx: &mut TxContext
    ) {
        let p = Proposal {
            // E04007 Fix: object::new returns UID, which matches the field type now.
            id: sui::object::new(ctx),
            creator,
            signatures: vector::empty<address>(),
            threshold,
            executed: false,
            time_lock_end,
        };
        // Transfer the newly created object to the creator address.
        transfer::transfer(p, tx_context::sender(ctx));
    }

    // W99010 Fix: This function should not be 'entry' if it's meant to be called from a PTB.
    // We assume it's meant to be called from a PTB, so we remove 'entry'.
    public fun sign_proposal(p: &mut Proposal, signer: address) {
        // do signer dedupe and push
        vector::push_back(&mut p.signatures, signer);
    }

    public fun is_approved(p: &Proposal): bool {
        (vector::length(&p.signatures) as u8) >= p.threshold
    }
}