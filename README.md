------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# UH60V Script Translator & Verification Framework

A MATLAB-based translation and verification tool designed to convert Army "Cinnamon Roll" flight test scripts into executable simulation objects for the UH-60V Black Hawk verification environment.

This project bridges structured flight test intent with executable MATLAB-based simulation logic, enabling both post-flight verification and pre-flight simulation.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## 🎯 Purpose

Modern Army aviation platforms require repeatable and automated verification workflows to ensure system integrity, avionics behavior, and mission logic accuracy.

This project was built to:

- Translate structured flight scripts written in the Army’s Cinnamon Roll language
- Convert those scripts into executable MATLAB class representations
- Enable automated simulation prior to flight
- Support verification and validation following flight execution
- Reduce manual scripting friction within the test environment

The goal was not simply translation — but reliable, repeatable test automation within a structured verification framework.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧠 System Overview

At a high level, the system performs the following sequence:

1. Reads structured Cinnamon Roll flight scripts
2. Parses and validates syntax
3. Builds MATLAB class-based representations of flight logic
4. Executes the translated objects within the UH60V test harness
5. Captures and logs verification outputs for analysis

This allows flight scenarios to be simulated before execution and verified after execution using a consistent translation pipeline.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🏗 Architecture

The system is structured with clear separation of concerns.

### 1️⃣ Translation Layer

**Input:** Cinnamon Roll script files  
**Output:** Structured MATLAB class instances

Components include:

- Script reader and tokenizer
- Syntax validation engine
- Abstract representation builder
- Translation engine mapping script constructs to MATLAB classes

This layer isolates parsing logic from execution logic to maintain modularity.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2️⃣ Core Class Hierarchy

The translated output is represented through a structured MATLAB class system.

Classes encapsulate:

- Flight segments
- Control sequences
- Parameter definitions
- Timing structures
- State transitions

Each script construct maps deterministically into a corresponding class object, preserving script intent while enabling MATLAB execution.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 3️⃣ Execution & Simulation Layer

This layer interfaces the translated MATLAB objects with:

- The UH60V verification framework
- MATLAB runtime execution workflows
- Structured logging mechanisms

Responsibilities include:

- Executing scenario logic
- Tracking state evolution
- Capturing verification metrics
- Generating reproducible outputs

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 4️⃣ Output & Reporting Layer

The system generates structured results including:

- Pass/fail verification outcomes
- Timing traces
- Parameter comparisons
- Execution logs

These outputs support both simulation validation and post-flight analysis workflows.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🚀 Example Execution Flow

1. Load Cinnamon Roll script file
2. Parse and validate script syntax
3. Translate script into MATLAB class objects
4. Execute objects within verification environment
5. Archive structured output for review

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🛠 Tech Stack

- Language: MATLAB
- Features Used:
  - Custom class definitions
  - File parsing and structured I/O
  - Object-oriented design
  - Execution logging frameworks
- Integration Context: UH60V verification and test environment

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 📐 Design Philosophy

This project was built around several core engineering principles:

- Separation of concerns between parsing and execution
- Deterministic translation from script to object
- Modular and extensible class design
- Transparent intermediate representations for debugging
- Reproducibility of test execution

The intent was to provide automation while preserving traceability and control.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 📈 Project Status

- Operational within internal test workflows
- Maintained on an as-needed basis
- Structured for clarity and extensibility

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧠 Engineering Takeaways

Key lessons from this project include:

- The importance of deterministic translation pipelines in safety-critical systems
- The value of object-oriented structure when mapping domain-specific languages
- The necessity of maintaining inspectable intermediate states for debugging and verification
- The benefits of designing automation systems that remain transparent to end users

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Notes

This repository represents a side project conducted alongside full-time work, focused on improving automation and verification efficiency within a structured Army aviation test context.
