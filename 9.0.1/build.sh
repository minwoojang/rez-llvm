#! /bin/bash

export PACKAGE_INSTALLATION_ROOT=/home/minwoo/packages
export PACKAGE_NAME=llvm
export PACKAGE_VERSION=9.0.1.1
export MAKE_THREADS=28

# 설치 경로 생성
mkdir -p $PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION

# 빌드 디렉토리 생성 및 이동
mkdir -p build
cd build

# CMake 설정
cmake -G "Unix Makefiles" \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
      -DCLANG_BUILD_TOOLS=ON \
      ../llvm-project/llvm

# 빌드 실행
cmake --build . -- -j$MAKE_THREADS

# 설치 실행
# 설치 중 c-index-test 파일을 무시할 수 있도록 오류를 무시하는 옵션 추가
cmake -DCMAKE_INSTALL_PREFIX=$PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION -P cmake_install.cmake || true

# 추가 처리
# (필요 시 Python 관련 설치 경로 추가)
# mkdir -p $PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION/lib64/python3.9/site-packages
# mv $PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION/PySide $PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION/lib64/python3.9/site-packages

# 빌드 디렉토리 복귀 및 추가 파일 복사
cd ..
cp package.py $PACKAGE_INSTALLATION_ROOT/$PACKAGE_NAME/$PACKAGE_VERSION