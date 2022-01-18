nextflow.enable.dsl=2

include { FASTQs_download } from './Process/FASTQ-download'
include { Contigs } from './Process/contigs'
include {  Align_Contigs; Map_Reads } from './Process/shiver'
include { Insert_slash } from './Process/insert'

//genomeFA = Channel.value(file(params.fasta))
//config_bowtie = Channel.fromPath(params.bowtie2)
//config_bwa = Channel.fromPath(params.bwa)
//config_smalt = Channel.fromPath(params.smalt)
//adapters = Channel.fromPath(params.adapters)
//primers = Channel.fromPath(params.primers)
//shiver = Channel.fromPath(params.shiver)

workflow {
    //Setting_shiver(shiver, genomeFA, config_bowtie, config_bwa, config_smalt, adapters, primers)
    FASTQs_download(Channel.from(file(params.FASTQ_input).readLines()))
    Insert_slash(FASTQs_download.out)
    Contigs(Insert_slash.out)
    Align_Contigs(Contigs.out)
    Map_Reads(Align_Contigs.out)
}