# Test Coverage Examples

This is a companion project to a blog post on test coverage in Ruby.

This project is organized as four top-level folders so each coverage stage can be inspected as a self-contained lesson with the source file and test file side by side.

## Structure

- `line_coverage/`
- `branch_coverage/`
- `condition_coverage/`
- `path_coverage/`

Each folder contains:

- `application_fund_review.rb`
- `application_fund_review_test.rb`

## Setup

```sh
bundle install
```

## Run the stages

Run all stages:

```sh
bundle exec rake
```

Run an individual stage:

```sh
bundle exec rake line
bundle exec rake branch
bundle exec rake condition
bundle exec rake path
```

## Coverage reports

Each stage writes its report to a separate folder:

- `docs/line_coverage/`
- `docs/branch_coverage/`
- `docs/condition_coverage/`
- `docs/path_coverage/`

After running the rake tasks, open:

- `docs/index.html`

That page links to all four per-stage SimpleCov reports.
