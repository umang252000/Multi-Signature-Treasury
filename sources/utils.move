module multisig_treasury::utils {
    use sui::clock::Clock;

    /// Return current timestamp in seconds
    public fun now_seconds(clock: &Clock): u64 {
        sui::clock::timestamp_ms(clock) / 1000
    }
}