process Insert_slash {
  tag "${SRR}"

  input:
  tuple val(SRR), path(fastq)
    
  output:
  tuple val(SRR), path("corr_${SRR}_*.fastq")
  
  script:
  """
  awk '{if (NR%4 == 1) {print \$1 \$2 "_/1"} else print}' ${SRR}_1.fastq > corr_${SRR}_1.fastq
  awk '{if (NR%4 == 1) {print \$1 \$2 "_/2"} else print}' ${SRR}_2.fastq > corr_${SRR}_2.fastq
  """

  stub:
  """
  touch corr_${SRR}_1.fastq
  touch corr_${SRR}_2.fastq
  """
}