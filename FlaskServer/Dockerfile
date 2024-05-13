# Python 이미지 사용
FROM python:3.8.10

# 작업 디렉터리 설정
WORKDIR /app

# yolov5 폴더 내의 의존성 파일 복사
COPY yolov5/requirements.txt .

# 필요한 패키지 설치
RUN python -m pip install --upgrade pip 
RUN pip install --no-cache-dir -r requirements.txt

# 나머지 애플리케이션 파일 복사
COPY . .

# 환경 변수 설정
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# 포트 5000 열기
EXPOSE 5000

# Flask 서버 실행
CMD ["python", "app.py"]
