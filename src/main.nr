fn main(k: Field, Hk: pub Field, Hfile: pub Field, C0: pub Field, C1: pub Field) {
    let keyHash = std::hash::pedersen_hash([k,0]);
    assert(keyHash == Hk);

    // 2. Decrypt ciphertext by XOR 
    let P0 = (C0 as u32) ^ (k as u32); 
    let P1 = (C1 as u32) ^ (k as u32);
    
    // 3. Verify that decrypted plaintext matches the expected hash
    let plaintext_hash = std::hash::pedersen_hash([P0 as Field, P1 as Field]);
    assert(plaintext_hash == Hfile);
}

#[test]
fn test_main() {
    let k: Field = 0x69206c696b65206e6163686f73;
    let Hk: Field = 0x033787e40b56554b03a980f03a55fbd5baf81cf563a228928b1598d34629bfd5;
    let Hfile: Field = 0x0c7fd394afe811b7a0ab0920233a8697c82c6059b87c29415b5171a2232cc60a;
    let C0: Field = 0x439a8b0d3fac7815de8cc5c2a2da8fe5;
    let C1: Field = 0xc85f7d2bffe1ea02b812cc9e8a9bb5dd;
    
    main(k, Hk, Hfile, C0, C1);
}
