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

import subprocess
import cv2

from pathlib import Path
import pathlib
temp = pathlib.PosixPath
pathlib.PosixPath = pathlib.WindowsPath


def safe_path(path):
    if sys.platform == "win32":  # 윈도우 환경인 경우
        return Path(path).as_posix()  # WindowsPath를 Posix 스타일 문자열로 변환
    return path

weights_path = safe_path("./best.pt")
source_path = safe_path("./image.jpg")
detect_file_path = safe_path("./yolov5/detect.py")

def crop_image(file_path):

    result_dir = './yolov5/runs/detect/exp/'

    # 기존 결과 삭제
    if os.path.exists(result_dir):
        import shutil
        shutil.rmtree(result_dir)
        
    cmd = f"python {detect_file_path} --weights {weights_path} --img 640 --conf 0.25 --source {source_path} --save-txt --save-conf --exist-ok"
    # cmd = f"python yolov5/detect.py --weights {weights_path} --source image.jpg --save-txt"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True) 

    # print(result)

    # 이미지 경로와 결과 파일 경로 설정
    # image_path = '/content/image.jpg'
    # txt_path = './yolov5/runs/detect/exp/labels/image.txt'  # 이 경로는 실제 결과 파일에 맞게 조정 필요
    txt_path = f'yolov5/runs/detect/exp/labels/{os.path.basename(file_path).replace(".jpg", ".txt")}'

    # txt_path = os.path.join(result_dir, 'labels', 'image.txt')

    # 이미지 로드
    image = cv2.imread(file_path)
    height, width, _ = image.shape

    # 결과 파일 읽기
    with open(txt_path, 'r') as file:
        lines = file.readlines()

    # 객체 데이터 파싱
    objects = []
    for line in lines:
        parts = line.strip().split()
        x_center, y_center, bbox_width, bbox_height = map(float, parts[1:5])
        x_center *= width
        y_center *= height
        bbox_width *= width
        bbox_height *= height
        x1 = int(x_center - bbox_width / 2)
        y1 = int(y_center - bbox_height / 2)
        x2 = int(x_center + bbox_width / 2)
        y2 = int(y_center + bbox_height / 2)
        objects.append((x1, y1, x2, y2))

    count = len(objects)
    # print("객체 개수:", count)

    if count == 0:
        return count

    # 이미지 중앙과 가장 가까운 객체 찾기
    image_center = (width / 2, height / 2)
    closest_object = min(objects, key=lambda obj: (image_center[0] - (obj[0]+obj[2])/2) ** 2 + (image_center[1] - (obj[1]+obj[3])/2) ** 2)

    # 가장 가까운 객체를 사용하여 이미지 크롭
    x1, y1, x2, y2 = closest_object
    cropped_image = image[y1:y2, x1:x2]

    # 크롭된 이미지 저장 또는 표시
    cv2.imwrite('./cropped_image.jpg', cropped_image)

    return count


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

    # Yolo 객체 탐지 및 Crop
    detected_cnt = crop_image(image_path)

    if detected_cnt == 0:
        predicted_class = 4
        garbage_class_name = "NONE"

        return predicted_class, garbage_class_name, detected_cnt


    cropped_image_path = './cropped_image.jpg'

    # 이미지 전처리
    prepared_image = prepare_image(cropped_image_path)

    model = load_model("cnn(batch_size_256_lr_e-3).h5", compile=False)

    class_names = open("labels.txt", "r", encoding='UTF8').readlines()

    # 모델을 사용하여 예측
    predictions = model.predict(prepared_image)
    predicted_class = np.argmax(predictions, axis=1)[0]

    # print("predicted_class:", predicted_class)

    class_name = class_names[predicted_class]
    garbage_class_name = class_name[2:-1]

    # print(f"Predicted class: {class_labels[predicted_class]}")
    
    return predicted_class, garbage_class_name, detected_cnt


