# estrutura_robot_api

Projeto de automação de testes de API com **Robot Framework** e pipeline CI/CD no **GitHub Actions**.

## Stack

| Componente | Biblioteca |
|---|---|
| Core | Robot Framework 7.x |
| API | robotframework-requests |
| JSON | robotframework-jsonlibrary |
| Relatórios | robotframework-metrics, allure-robotframework |
| Lint | robotframework-robocop |

## Estrutura

```
├── .github/workflows/robot-tests.yml   # Pipeline CI
├── config/                             # Ambientes e variáveis
├── resources/                          # Keywords reutilizáveis
├── tests/                              # Suites de teste
├── data/                               # Dados de teste
├── requirements.txt
└── robot.toml
```

## Execução local

```bash
# Instalar dependências
pip install -r requirements.txt

# Rodar smoke tests
robot --variable BASE_URL:https://jsonplaceholder.typicode.com --include smoke tests/

# Rodar todos os testes
robot --variable BASE_URL:https://jsonplaceholder.typicode.com tests/

# Rodar por tag
robot --include api tests/
robot --include regression tests/
```

## Tags disponíveis

| Tag | Descrição |
|---|---|
| `smoke` | Testes críticos de conectividade |
| `api` | Testes de API |
| `health` | Health checks |
| `users` | CRUD de usuários |
| `auth` | Autenticação |
| `regression` | Suite de regressão |

## Pipeline GitHub Actions

O workflow roda automaticamente em:
- Push/PR para `main` ou `develop`
- Schedule: Seg-Sex às 06:00 UTC
- Manual via `workflow_dispatch`

### Artefatos gerados

| Arquivo | Uso |
|---|---|
| `output.xml` | Parser customizado / integração com sistemas |
| `junit.xml` | CI, SonarQube, dashboards |
| `metrics.json` | Dashboards e relatórios executivos |
| `report.html` / `log.html` | Visualização humana |

## Integração com sistema de relatórios

Os artifacts ficam disponíveis por 30 dias no GitHub Actions. Use `output.xml` ou `metrics.json` para alimentar seu sistema:

```python
from robot.api import ExecutionResult, ResultVisitor

class MetricsExtractor(ResultVisitor):
    def __init__(self):
        self.tests = []

    def visit_test(self, test):
        self.tests.append({
            "name": test.name,
            "status": test.status,
            "duration_ms": test.elapsedtime,
            "tags": list(test.tags),
        })

result = ExecutionResult("results/output.xml")
extractor = MetricsExtractor()
result.visit(extractor)
```

## Ambientes

Configure em `config/environments.yaml`:

- `dev` — desenvolvimento
- `staging` — homologação
- `prod` — produção

Substitua a URL de exemplo (`jsonplaceholder.typicode.com`) pela URL real da sua API.
