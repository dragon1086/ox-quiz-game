// 퀴즈 문제 데이터
const quizData = [
    {
        question: '대한민국의 수도는 서울이다.',
        answer: true
    },
    {
        question: '지구는 태양계에서 세 번째로 큰 행성이다.',
        answer: false
    },
    {
        question: '인간의 심장은 주먹만한 크기이다.',
        answer: true
    },
    {
        question: '남극에도 우편번호가 있다.',
        answer: true
    },
    {
        question: '피라미드는 노예들이 만들었다.',
        answer: false
    },
    {
        question: '사람의 뼈는 206개이다.',
        answer: true
    },
    {
        question: '낙타의 혹에는 물이 저장되어 있다.',
        answer: false
    },
    {
        question: '모든 포유류는 땀샘이 있다.',
        answer: false
    },
    {
        question: '번개는 위에서 아래로 친다.',
        answer: false
    },
    {
        question: '사람의 손가락 지문은 평생 변하지 않는다.',
        answer: true
    }
];

let currentQuestion = 0;
let score = 0;

// 요소 선택
const questionEl = document.getElementById('question');
const scoreEl = document.getElementById('score');
const remainingEl = document.getElementById('remaining');
const resultEl = document.getElementById('result');
const nextBtn = document.getElementById('next-btn');
const restartBtn = document.getElementById('restart-btn');
const trueFalseButtons = document.querySelectorAll('#true-btn, #false-btn');

// 게임 초기화
function initGame() {
    currentQuestion = 0;
    score = 0;
    shuffleQuestions();
    showQuestion();
    updateScore();
    updateRemaining();
    hideElement(resultEl);
    hideElement(nextBtn);
    hideElement(restartBtn);
    enableButtons();
}

// 문제 섞기
function shuffleQuestions() {
    for (let i = quizData.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [quizData[i], quizData[j]] = [quizData[j], quizData[i]];
    }
}

// 문제 표시
function showQuestion() {
    const question = quizData[currentQuestion];
    questionEl.textContent = question.question;
}

// 답변 확인
function checkAnswer(userAnswer) {
    const correctAnswer = quizData[currentQuestion].answer;
    const isCorrect = userAnswer === correctAnswer;
    
    if (isCorrect) {
        score++;
        showResult('정답입니다! 🎉', 'correct');
    } else {
        showResult('틀렸습니다! 😢', 'incorrect');
    }
    
    updateScore();
    disableButtons();
    showElement(nextBtn);
    
    if (currentQuestion === quizData.length - 1) {
        hideElement(nextBtn);
        showElement(restartBtn);
        // 최종 결과 표시
        const finalScore = Math.round((score / quizData.length) * 100);
        showResult(`게임 종료! 최종 점수: ${finalScore}점`, score >= 7 ? 'correct' : 'incorrect');
    }
}

// 결과 표시
function showResult(message, className) {
    resultEl.textContent = message;
    resultEl.className = `result ${className}`;
    showElement(resultEl);
}

// 점수 업데이트
function updateScore() {
    scoreEl.textContent = score;
}

// 남은 문제 수 업데이트
function updateRemaining() {
    remainingEl.textContent = quizData.length - currentQuestion;
}

// 다음 문제로
function nextQuestion() {
    currentQuestion++;
    hideElement(resultEl);
    hideElement(nextBtn);
    enableButtons();
    showQuestion();
    updateRemaining();
}

// 게임 재시작
function restartGame() {
    initGame();
}

// 버튼 비활성화
function disableButtons() {
    trueFalseButtons.forEach(btn => btn.disabled = true);
}

// 버튼 활성화
function enableButtons() {
    trueFalseButtons.forEach(btn => btn.disabled = false);
}

// 요소 숨기기
function hideElement(element) {
    element.classList.add('hidden');
}

// 요소 보이기
function showElement(element) {
    element.classList.remove('hidden');
}

// 게임 시작
initGame();