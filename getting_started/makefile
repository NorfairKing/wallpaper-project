GHC = ghc
GHC_FLAGS = -O2 -fforce-recomp -idoc/examples -ibenchmarks -isrc -itests

NAME = wallpaper

SRC = $(NAME).hs
BIN = $(NAME).bin

all: bin style
	
bin:
	$(GHC) $(GHC_FLAGS) -o $(BIN) --make $(SRC)

LESSC = lessc
STYLE_SRC = $(NAME).less
STYLE = $(NAME).css

style:
	$(LESSC) $(STYLE_SRC) > $(STYLE)
	
DIRTY_EXT = *.o *. *.hi *.png *.css *.html *.bin

clean:
	rm -f $(DIRTY_EXT)
