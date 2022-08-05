const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "contract balance",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let waveTxn;
  waveTxn = await waveContract.wave("someMessage");
  await waveTxn.wait();

  waveCount = await waveContract.getTotalWaves();

  waveTxn = await waveContract.connect(randomPerson).wave("I am a messsssage");
  await waveTxn.wait();

  waveTxn = await waveContract.connect(randomPerson).wave("I am a messsssage");
  await waveTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Now contract balance",
    hre.ethers.utils.formatEther(contractBalance)
  );

  waveCount = await waveContract.getTotalWaves();

  interactionCount = await waveContract.getWhoInteracted();

  let allWaves;
  allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (e) {
    console.log(e);
    process.exit(1);
  }
};

runMain();
