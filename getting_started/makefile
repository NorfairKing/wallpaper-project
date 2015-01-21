GHC = ghc
GHC_FLAGS = -O2 -fforce-recomp -idoc/examples -ibenchmarks -isrc -itests

DIRTY_EXT = *.o *. *.hi *.html *.png

BIN = wallpaper
SRC = wallpaper.hs

all:
	$(GHC) $(GHC_FLAGS) -o $(BIN) --make $(SRC)

clean:
	rm -f $(DIRTY_EXT) $(BIN)
