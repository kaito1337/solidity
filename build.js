let minerAcc = personal.newAccount("123");
for (let i = 0; i < eth.accounts.length; i++) {
    const account = eth.accounts[i];
    personal.unlockAccount(account, "123", 0);
}

miner.setEtherbase(minerAcc);
