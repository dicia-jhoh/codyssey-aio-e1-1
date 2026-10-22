# 기존 웹 서버 이미지(nginx:alpine)를 베이스로 정적 콘텐츠와 운영 설정만 바꾼다
FROM nginx:alpine

# 1) 이미지 설명 — docker inspect 로 누가·무엇을 만들었는지 확인할 수 있게
LABEL org.opencontainers.image.title="e11-web" \
      org.opencontainers.image.description="E1-1 개발자 작업실 정적 웹 서버"

# 2) 실행 환경 표시 — 컨테이너 안에서 printenv APP_ENV 로 확인
ENV APP_ENV=dev

# 3) 정적 콘텐츠 교체 — 기본 nginx 환영 페이지 대신 우리 페이지
COPY app/ /usr/share/nginx/html/

# 4) 헬스체크 — 30초마다 /health 를 받아 실패하면 unhealthy 로 표시
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1/health || exit 1

EXPOSE 80
