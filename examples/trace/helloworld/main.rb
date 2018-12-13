# Copyright 2017, OpenCensus Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'pry'
$LOAD_PATH.unshift File.expand_path("../../lib", __dir__)
require "opencensus"


$execution_context = OpenCensus::Trace
$print_exporter = OpenCensus::Trace::Exporters::Logger
$tracer = OpenCensus::Trace
$always_on = OpenCensus::Trace::Samplers::AlwaysSample

def function_to_trace
  sleep(1)
end

def main

  tracing = $tracer.start_request_trace()
  sampler = $always_on.new()

  span_context = OpenCensus::Trace::SpanContext.new(trace_data = 'hello', parent = 'parent', span_id = 'span_id', trace_options = 'trace_options', same_process_as_parent = 'same_process_as_parent')
  new_span = OpenCensus::Trace::SpanBuilder.new(span_context)

  tracing = $tracer.start_request_trace()
  sampler = $always_on.new()

  # Explicitly create spans
  $tracer.start_span(new_span)

  # Get current span
  p $execution_context.span_context()

  # Explicitly end span
  $tracer.start_span(new_span)

end


 main()
