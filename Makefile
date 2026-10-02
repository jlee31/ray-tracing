CXX      := c++
CXXFLAGS := -std=c++17 -O2 -Wall -Wextra
BUILD    := build

$(BUILD)/inweekend: src/main.cc $(wildcard src/*.h) | $(BUILD)
	$(CXX) $(CXXFLAGS) -o $@ src/main.cc

$(BUILD):
	mkdir -p $(BUILD)

# Render to image.ppm
image.ppm: $(BUILD)/inweekend
	$(BUILD)/inweekend > $@

# Convert to PNG so macOS Preview can open it
image.png: image.ppm
	sips -s format png $< --out $@ > /dev/null

# Build, render, and open the result
.PHONY: run clean
run: image.png
	open image.png

clean:
	rm -rf $(BUILD) image.ppm image.png
