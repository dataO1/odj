#include <audiorw.hpp>
#include <vector>

int main(int argc, char **argv) {

  double sample_rate;
  std::vector<std::vector<double>> audio =
      audiorw::read("example.wav", sample_rate);

  // Read the 10th sample from the left channel
  double left_sample = audio[0][10];

  // Read the 10th sample from the right channel
  double right_sample = audio[1][10];
}
