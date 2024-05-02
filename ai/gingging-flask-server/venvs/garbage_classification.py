import sys, os, glob
from keras.models import Sequential
from keras.layers import Convolution2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
# from keras.utils import np_utils
from keras import utils
from keras.models import load_model  # TensorFlow is required for Keras to work
from PIL import Image, ImageOps  # Install pillow instead of PIL
import numpy as np

from tensorflow.keras.applications.resnet50 import preprocess_input
from tensorflow.keras.preprocessing import image
import numpy as np
from PIL import Image

def prepare_image(file_path):
    # Load the image
    img = Image.open(file_path).convert('RGB')  # Ensure image is in RGB

    # Resize image to match model's expected sizing
    img = img.resize((384, 384))

    # Convert the image to a numpy array
    img_array = image.img_to_array(img)

    # Ensure data type consistency
    img_array = img_array.astype('float32')  # Ensure float32 data type

    # Expand dimensions to fit model input
    img_array = np.expand_dims(img_array, axis=0)

    # Preprocess the input image array
    img_array = preprocess_input(img_array)

    return img_array

def classify_garbage(image_path):
    # 예를 들어 이미지 경로
    # img_path = './test_data/test4.jfif'

    # 이미지 전처리
    prepared_image = prepare_image(image_path)

    model = load_model("gingging.h5", compile=False)

    class_names = open("labels.txt", "r", encoding='UTF8').readlines()

    # 모델을 사용하여 예측
    predictions = model.predict(prepared_image)
    predicted_class = np.argmax(predictions, axis=1)[0]

    print("predicted_class:", predicted_class)

    class_name = class_names[predicted_class]
    garbage_class_name = class_name[2:-1]

    # print(f"Predicted class: {class_labels[predicted_class]}")
    
    return garbage_class_name, predicted_class


def classify_species(image_path):

    root_dir = "./"

    image_size = 384
    # nb_classes = len(image_files)

    categories = ["glass", 
              "metal", 
              "plastic", 
              "trash"] 
    
    X = []
    files = []

    fname = image_path

    img = Image.open(fname)
    img = img.convert("RGB")
    img = img.resize((image_size, image_size))
    in_data = np.asarray(img)
    in_data = in_data.astype("float") / 256
    X.append(in_data)

    X = np.array(X)

    model = load_model("gingging.h5", compile=False)

    class_names = open("labels.txt", "r", encoding='UTF8').readlines()

    # 예측 실행
    pre = model.predict(X)
    # i, p = enumerate(pre)

    y = pre.argmax()

    class_name = class_names[y]
    garbage_class_name = class_name[2:]

    print("입력:", fname)
    print("인덱스: ", y)
    print("예측:", "[", y,"]", garbage_class_name)


    return garbage_class_name, y
