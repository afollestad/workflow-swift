/*
 * Copyright 2020 Square Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#if DEBUG

    import XCTest

    extension RenderTester {
        @available(*, deprecated, message: "See `RenderTester` documentation for new style.")
        @discardableResult
        public func render(file: StaticString = #file, line: UInt = #line, with expectations: RenderExpectations<WorkflowType>, assertions: (WorkflowType.Rendering) -> Void) -> RenderTester<WorkflowType> {
            var tester = self

            for expectedWorkflow in expectations.expectedWorkflows {
                expectedWorkflow.expect(in: &tester, file: file, line: line)
            }

            for (_, expectedSideEffect) in expectations.expectedSideEffects {
                expectedSideEffect.expect(in: &tester, file: file, line: line)
            }

            let result = tester.render(file: file, line: line, assertions: assertions)

            if let expectedState = expectations.expectedState {
                expectedState.verify(in: result, file: file, line: line)
            }

            if let expectedOutput = expectations.expectedOutput {
                expectedOutput.verify(in: result, file: file, line: line)
            }

            return RenderTester(
                workflow: tester.workflow,
                state: result.state
            )
        }

        @available(*, deprecated, message: "See `RenderTester` documentation for new style.")
        @discardableResult
        public func render(
            file: StaticString = #file, line: UInt = #line,
            expectedState: ExpectedState<WorkflowType>? = nil,
            expectedOutput: ExpectedOutput<WorkflowType>? = nil,
            expectedWorkflows: [WorkflowTesting.ExpectedWorkflow] = [],
            expectedSideEffects: [WorkflowTesting.ExpectedSideEffect<WorkflowType>] = [],
            assertions: (WorkflowType.Rendering) -> Void
        ) -> RenderTester<WorkflowType> {
            let expectations = RenderExpectations(
                expectedState: expectedState,
                expectedOutput: expectedOutput,
                expectedWorkflows: expectedWorkflows,
                expectedSideEffects: expectedSideEffects
            )

            return render(file: file, line: line, with: expectations, assertions: assertions)
        }

        @available(*, deprecated, renamed: "verifyState(_:)")
        @discardableResult
        public func assert(state assertions: (WorkflowType.State) -> Void) -> RenderTester<WorkflowType> {
            assertions(state)
            return self
        }
    }

#endif
