class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  edam: http://edamontology.org/
id: gatk_apply_bqsr_4_1_2_0
baseCommand:
  - gatk
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 4
      prefix: '--reference'
    doc: Reference sequence
    secondaryFiles:
      - .fai
      - ^.dict
  - id: create_output_bam_index
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--create-output-bam-index'
  - id: bqsr_recal_file
    type: File
    inputBinding:
      position: 4
      prefix: '--bqsr-recal-file'
    doc: >-
      Input recalibration table for BQSR. Only run ApplyBQSR with the covariates
      table created from the input BAM
  - id: input
    type: File
    inputBinding:
      position: 4
      prefix: '--input'
    doc: A BAM file containing input read data
    secondaryFiles:
      - ^.bai
  - id: output_file_name
    type: string?
    doc: Output file name. Not Required
  - id: add_output_sam_program_record
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--add-output-sam-program-record'
  - id: add_output_vcf_command_line
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--add-output-vcf-command-line'
  - id: arguments_file
    type: File?
    inputBinding:
      position: 6
      prefix: '--arguments_file'
  - id: cloud_index_prefetch_buffer
    type: int?
    inputBinding:
      position: 6
      prefix: '--cloud-index-prefetch-buffer'
  - id: cloud_prefetch_buffer
    type: int?
    inputBinding:
      position: 6
      prefix: '--cloud-prefetch-buffer'
  - id: create_output_bam_md5
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--create-output-bam-md5'
  - id: create_output_variant_index
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--create-output-variant-index'
  - id: create_output_variant_md5
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--create-output-variant-md5'
  - id: disable_bam_index_caching
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--disable-bam-index-caching'
  - id: disable_read_filter
    type: string?
    inputBinding:
      position: 6
      prefix: '--disable-read-filter'
  - id: disable_sequence_dictionary_validation
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--disable-sequence-dictionary-validation'
  - default: true
    id: emit_original_quals
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--emit-original-quals'
  - id: exclude_intervals
    type: string?
    inputBinding:
      position: 6
      prefix: '--exclude-intervals'
  - id: gatk_config_file
    type: File?
    inputBinding:
      position: 6
      prefix: '--gatk-config-file'
  - id: gcs_max_retries
    type: int?
    inputBinding:
      position: 6
      prefix: '--gcs-max-retries'
  - id: gcs_project_for_requester_pays
    type: string?
    inputBinding:
      position: 6
      prefix: '--gcs-project-for-requester-pays'
  - id: global_qscore_prior
    type: float?
    inputBinding:
      position: 6
      prefix: '--global-qscore-prior'
  - id: interval_exclusion_padding
    type: int?
    inputBinding:
      position: 6
      prefix: '--interval-exclusion-padding'
  - id: interval_merging_rule
    type: string?
    inputBinding:
      position: 6
      prefix: '--interval-merging-rule'
  - id: interval_padding
    type: int?
    inputBinding:
      position: 6
      prefix: '--interval-padding'
  - id: interval_set_rule
    type: string?
    inputBinding:
      position: 6
      prefix: '--interval-set-rule'
  - id: intervals
    type: string?
    inputBinding:
      position: 6
      prefix: '--intervals'
  - id: lenient
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--lenient'
  - id: preserve_qscores_less_than
    type: int?
    inputBinding:
      position: 6
      prefix: '--preserve-qscores-less-than'
  - id: quantize_quals
    type: int?
    inputBinding:
      position: 6
      prefix: '--quantize-quals'
  - id: quiet
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--QUIET'
  - id: read_filter
    type: string?
    inputBinding:
      position: 6
      prefix: '--read-filter'
  - id: read_index
    type: string?
    inputBinding:
      position: 6
      prefix: '--read-index'
  - id: read_validation_stringency
    type: string?
    inputBinding:
      position: 6
      prefix: '--read-validation-stringency'
  - id: seconds_between_progress_updates
    type: float?
    inputBinding:
      position: 6
      prefix: '--seconds-between-progress-updates'
  - id: sequence_dictionary
    type: File?
    inputBinding:
      position: 6
      prefix: '--sequence-dictionary'
  - id: sites_only_vcf_output
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--sites-only-vcf-output'
  - id: use_jdk_deflater
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--use-jdk-deflater'
  - id: use_jdk_inflater
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--use-jdk-inflater'
  - id: use_original_qualities
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--use-original-qualities'
  - id: memory_overhead
    type: int?
  - id: memory_per_job
    type: int?
  - id: number_of_threads
    type: int?
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_bqsr.bam')
            }
        }
    secondaryFiles:
      - ^.bai
label: gatk_apply_bqsr_4.1.2.0
arguments:
  - position: 0
    prefix: '--java-options'
    valueFrom: "${\n  if(inputs.memory_per_job && inputs.memory_overhead) {\n   \n    if(inputs.memory_per_job % 1000 == 0) {\n    \t\n      return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"\n    }\n    else {\n      \n      return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\" \n    }\n  }\n  else if (inputs.memory_per_job && !inputs.memory_overhead){\n    \n    if(inputs.memory_per_job % 1000 == 0) {\n    \t\n      return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"\n    }\n    else {\n      \n      return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\" \n    }\n  }\n  else if(!inputs.memory_per_job && inputs.memory_overhead){\n    \n    return \"-Xmx4G\"\n  }\n  else {\n    \n  \treturn \"-Xmx4G\"\n  }\n}"
  - position: 2
    prefix: '--output'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_bqsr.bam')
          }
      }
  - position: 2
    prefix: '--tmp-dir'
    valueFrom: .
  - position: 1
    prefix: ''
    separate: false
    valueFrom: ApplyBQSR
requirements:
  - class: ResourceRequirement
    ramMin: 10000
    coresMin: 8
#     ramMin: "${\r  if(inputs.memory_per_job && inputs.memory_overhead) {\r   \r    return inputs.memory_per_job + inputs.memory_overhead\r  }\r  else if (inputs.memory_per_job && !inputs.memory_overhead){\r    \r   \treturn inputs.memory_per_job + 2000\r  }\r  else if(!inputs.memory_per_job && inputs.memory_overhead){\r    \r    return 8000 + inputs.memory_overhead\r  }\r  else {\r    \r  \treturn 8000 \r  }\r}"
#     coresMin: "${\r  if (inputs.number_of_threads) {\r    \r   \treturn inputs.number_of_threads \r  }\r  else {\r    \r    return 1\r  }\r}"
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.2.0'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': gatk4
    'doap:revision': 4.1.2.0