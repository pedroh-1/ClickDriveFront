# ClickDrive - Sistema de Gestão Integrada para Autoescolas

**Trabalho Acadêmico de Programação para dispositivos móveis**

**Membros do Grupo:**
* Deyvson Mendes Rodrigues
* João Kevin Dias Santos
* Pedro Henrique Nunes Oliveira

---

## 1. DESCRIÇÃO DO PROBLEMA

A gestão de Centros de Formação de Condutores (Autoescolas) enfrenta desafios significativos devido à fragmentação de processos manuais. A dificuldade em acompanhar o progresso pedagógico dos alunos (aulas e simulados), o controle financeiro impreciso de aulas realizadas e a falta de canais de feedback estruturados comprometem a eficiência operacional e a qualidade do ensino. O **ClickDrive** resolve esses problemas centralizando a jornada do aluno, do instrutor e da administração em uma única plataforma digital.

---

## 2. REQUISITOS E CASOS DE USO

### Requisitos Funcionais (RF):
* | **RF01** | Cadastro de novos usuários | Essencial | Usuário comum | Permitir que uma pessoa se registre na plataforma fornecendo nome, e-mail, senha e telefone. |
* | **RF02** | Autenticação de usuários | Importante | Usuário comum | Permitir que o usuário conecte-se e desconecte-se do sistema de forma segura. |
* | **RF03** | Solicitar candidatura a instrutor | Essencial | Usuário comum | Permitir que um usuário envie documentação e solicite aprovação como instrutor. |
* | **RF04** | Visualização de dicas categorizadas | Essencial | Usuário comum | Permitir que o usuário visualize dicas de trânsito organizadas por categorias. |
* | **RF05** | Buscar instrutores por categoria | Essencial | Aluno | Permitir que o aluno busque instrutores disponíveis por categoria de veículo. |
* | **RF06** | Visualizar agenda de instrutor | Essencial | Aluno | Permitir que o aluno visualize a disponibilidade de um instrutor específico. |
* | **RF07** | Solicitar agendamento de aula | Essencial | Aluno | Permitir que o aluno solicite o agendamento de uma aula prática. |
* | **RF08** | Visualizar histórico de aulas | Essencial | Aluno | Permitir que o aluno visualize o histórico de aulas e respectivos status. |
* | **RF09** | Realizar avaliação de aula | Essencial | Aluno | Permitir que o aluno atribua nota e comentário após a conclusão de uma aula. |
* | **RF10** | Realizar simulados teóricos | Essencial | Aluno | Permitir que o aluno realize simulados de provas teóricas do DETRAN. |
* | **RF11** | Visualizar resultado do simulado | Essencial | Aluno | Permitir que o aluno visualize resultado, pontuação e situação de aprovação no simulado. |
* | **RF12** | Gerenciar disponibilidade | Essencial | Instrutor | Permitir que o instrutor cadastre e altere seus dias e horários disponíveis. |
* | **RF13** | Aceitar ou recusar solicitações de aula | Essencial | Instrutor | Permitir que o instrutor confirme ou recuse solicitações de aula. |
* | **RF14** | Visualizar alunos vinculados | Essencial | Instrutor | Permitir que o instrutor visualize alunos vinculados às suas aulas. |
* | **RF15** | Gerenciar perfil profissional | Essencial | Instrutor | Permitir que o instrutor atualize valor da hora, credenciamento DETRAN e categoria. |
* | **RF16** | Validar candidatura de instrutor | Essencial | Administrador | Permitir que o administrador altere o status da candidatura para pendente, em análise, aprovada ou reprovada. |
* | **RF17** | Processar pagamento de aulas | Essencial | Administrador | Permitir que o sistema processe o pagamento das aulas e gere o registro financeiro. |
* | **RF18** | Gerenciar banco de questões | Essencial | Administrador | Permitir que o administrador insira, edite e remova questões dos simulados. |
* | **RF19** | Cancelar aula com antecedência | Essencial | Aluno | Permitir que o aluno cancele uma aula com até 12 horas de antecedência. |

### Casos de Uso :
<img width="1152" height="797" alt="Captura de tela 2026-06-15 214540" src="https://github.com/user-attachments/assets/75c614b3-c7a4-4cf8-aab9-b175466d6b90" />
<img width="803" height="472" alt="Captura de tela 2026-06-15 214558" src="https://github.com/user-attachments/assets/e85e71d4-ba7e-4e0e-9333-cd74e8008f6d" />
<img width="1153" height="692" alt="Captura de tela 2026-06-15 214612" src="https://github.com/user-attachments/assets/ba53e74b-1eb9-4d22-bd0f-1f95e2ce2332" />


---

## 3. DIAGRAMAS DE CLASSE E MODELAGEM

### 3.1 Diagrama de Classes (Lógica de Negócio)

<img width="1126" height="787" alt="Captura de tela 2026-06-15 214644" src="https://github.com/user-attachments/assets/5c81f500-9213-4bd1-bd4d-61038b49c569" />


### 3.2 DER (Diagrama Entidade Relacionamento)

<img width="800" height="727" alt="image" src="https://github.com/user-attachments/assets/c2b97c1a-1aa2-475e-869c-07386aa24de6" />


---

## 4. EXPLICAÇÃO DA IMPLEMENTAÇÃO

O projeto foi desenvolvido utilizando o ecossistema **Spring Boot**, adotando as seguintes práticas:

*   **Padrão MVC e Layered Architecture:** Separação clara entre Controladores (entrada de dados), Serviços (regras de negócio) e Repositórios (acesso ao banco).
*   **Mapeamento DTO (Data Transfer Object):** Utilização de `records` Java e **MapStruct** para garantir que as entidades de banco de dados não sejam expostas diretamente na API, aumentando a segurança e flexibilidade.
*   **Bean Validation:** Implementação de validações rigorosas (@NotBlank, @NotNull, @Size) para garantir a integridade dos dados recebidos.
*   **Gestão de Estados:** Uso de Enums para controlar ciclos de vida complexos, como o status de pagamentos (PENDENTE, PAGO, ESTORNADO, CANCELADO).
*   **Testes Unitários:** Implementação de testes seguindo o padrão **AAA (Arrange, Act, Assert)** com JUnit e Mockito.

---

## 5. PROJETO E TECNOLOGIAS

*   **Linguagem:** Java 
*   **Framework:** Spring Boot 3.4.2
*   **Banco de Dados:** MySQL 
*   **Documentação:** Swagger/OpenAPI 
*   **Persistência:** Spring Data JPA / Hibernate

---

## 6. CONCLUSÃO

O ClickDrive atende aos requisitos propostos para a modernização da gestão de autoescolas. A arquitetura robusta permite a escalabilidade do sistema para novas funcionalidades, como um aplicativo mobile para alunos. A implementação de simulados automatizados e o controle financeiro rígido demonstram a aplicação prática de conceitos avançados de engenharia de software e padrões de projeto.

---

## 7. COMO EXECUTAR

1.  Configure o banco de dados em `src/main/resources/application.properties`.
2.  Execute `./mvnw spring-boot:run`.
3.  Acesse a documentação em `http://localhost:8080/swagger-ui.html`.
