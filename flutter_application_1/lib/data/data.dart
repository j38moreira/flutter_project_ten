import '../models/atividade.dart';
import '../models/user.dart';

List<User> users = [
  User(1, 'Teste', 'teste@quickdrop.com', 'teste', 1234567890123456, 2025, 123, 'assets/images/profile.png',
    [
      Atividade('Laptop Asus', DateTime(2023, 11, 20), 1.5, 35.87, 24.95, 1.99, 'Amarante', 'Baião', custo: 3.78),
      Atividade('Caixa', DateTime(2023, 12, 22), 4.0, 8, 8, 8, 'Lavra', 'Leça da Palmeira', custo: 2.51),
    ],
  ),
  User(2, 'Bob', 'bob@exemplo.com', 'bob456', 9876543210987654, 2025, 789, 'assets/images/profile.png',
    [
      Atividade('Cadeira de Escritório', DateTime(2023, 9, 10), 3.2, 70, 40, 30, 'Gondomar', 'Paços de Ferreira', custo: 86.0),
      Atividade('Livro', DateTime(2023, 11, 28), 0.3, 20, 13, 3, 'Maia', 'Leça do Balio', custo: 2.78),
    ],
  ),

  User(3, 'Carol', 'carol@example.com', 'carol789', 1111222233334444, 2028, 101, 'assets/images/profile.png',
    [
      Atividade('Smartphone iPhone', DateTime(2023, 8, 18), 0.6, 14.67, 7.15, 0.77, 'Santo Tirso', 'Trofa', custo: 2.08),
      Atividade('Teclado Mecânico', DateTime(2023, 11, 12), 1.8, 3, 44, 13, 'Paredes', 'Penafiel', custo: 3.72),
    ],
  ),
];
