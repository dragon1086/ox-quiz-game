import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '🎮 OX 퀴즈 게임',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '점수: ${quizProvider.score}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        '남은 문제: ${quizProvider.remainingQuestions}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Center(
                      child: Text(
                        quizProvider.questions[quizProvider.currentQuestionIndex].questionText,
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (!quizProvider.isAnswered) ...[                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => quizProvider.checkAnswer(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('O', style: TextStyle(fontSize: 24)),
                        ),
                        ElevatedButton(
                          onPressed: () => quizProvider.checkAnswer(false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('X', style: TextStyle(fontSize: 24)),
                        ),
                      ],
                    ),
                  ],
                  if (quizProvider.isAnswered) ...[                    
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: quizProvider.lastAnswerCorrect!
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        quizProvider.lastAnswerCorrect!
                            ? '정답입니다! 🎉'
                            : '틀렸습니다! 😢',
                        style: TextStyle(
                          fontSize: 20,
                          color: quizProvider.lastAnswerCorrect!
                              ? Colors.green
                              : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (quizProvider.isLastQuestion) ...[                      
                      Text(
                        '게임 종료! 최종 점수: ${quizProvider.finalScore}점',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: quizProvider.restartQuiz,
                        child: const Text('다시 시작'),
                      ),
                    ] else ...[                      
                      ElevatedButton(
                        onPressed: quizProvider.nextQuestion,
                        child: const Text('다음 문제'),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
