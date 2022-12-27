let minerAcc = "0x941710e12b67f13090638e5e40adbb39e49c0db8";
for (let i = 0; i < eth.accounts.length; i++) {
    const account = eth.accounts[i];
    personal.unlockAccount(account, "123", 0);
}

miner.setEtherbase(minerAcc);
