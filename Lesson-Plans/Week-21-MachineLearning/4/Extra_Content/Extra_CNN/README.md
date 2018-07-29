Instructor Do: Convolutional Neural Networks (0:15)

* **File**: [CNNs.pptx](CNNs.pptx)

* Walk through the slideshow and explain the following:

  * Convolutional Networks are a key component to computer vision in machine learning. They are used in a wide range of applications including image recognition, self-driving cars, and medical imaging.

  * Convolutional Neural Networks employ convolutional filtering layers to help detect spatial features in images. Those features are then fed into a final fully connected layer that makes the final predictions.

  * Convolutional layers help detect spatial features by making certain features stand out. These filters typically increase in complexity as you move through the network.

    * The first filter layers in a CNN typically detect low level features such as lines, edges, and colors.

    * Middle filter layers typically detect features such as pieces, parts, or patterns.

    * Final filter layers are used to detect high level features such as faces or objects.

  * Multiple Filters can be stacked together. Think of this as the device that optometrists use to check your vision. Convolutional layers stack multiple filters together to enhance spatial features in an image.

  * Convolutional architectures can become incredibly complex as can be seen in the example of Google's Inception model.

  * Keras, however, makes creating CNNs a breeze!
