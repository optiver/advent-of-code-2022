# Build instructions

Installing rocky requires JVM + rocky itself:

```sh
sudo apt install default-jre
```

To install a rockstar interpreter:
```sh
git clone git@github.com:gaborsch/rocky.git
cd rocky
sudo sh install.sh
```

# Running instructions

The program will read from stdout

```sh
cat [input.txt] | rockstar solution.rock
```
