############ Enrichment analysis using g:profiler python package#####################################
###################################################################################################

#AGP pathways pipeline paper
from gprofiler import gprofiler
import pandas as pd

# The revigo analysis code was obtained from scrape_revigo.py, hosted at https://gist.github.com/SamDM/b7e8a13a5529c24291e293ee6ebe2366
# The code was added here to show an example. Please visit the reffered github page to get more details about the code
def Revigo_ana(Go_string):
    from robobrowser import RoboBrowser
    import re
    import lxml

    br = RoboBrowser(parser="lxml")
    br.open("http://revigo.irb.hr/")

    form = br.get_form()
    form["goList"].value = Go_string

    br.submit_form(form)

    download_csv_link = br.find("a", href=re.compile("export.jsp"))
    br.follow_link(download_csv_link)
    csv_content = br.response.content.decode("utf-8")
    # write results to file
    f = open('Revigo_Analysis_results.csv', 'w')
    f.write(csv_content)
    f.close()
    print("Revigo results written to file: Revigo_Analysis_results")


def enrich_ana (specie,correction_method,database,state_threshold):

    enrichment = gprofiler(query,organism=specie, correction_method= correction_method, src_filter=database)

    if len(enrichment) is 0:
        print("No significantly enriched terms were found")

    else:
        enrichment.to_csv ('Enrichment_results.CSV')
        print("Enriched terms written to file: Enrichment_results")
        Input_revigo = enrichment[['term.id','p.value']]
        Input_revigo= Input_revigo[Input_revigo['p.value']<state_threshold]
        Input_revigo=Input_revigo.values.astype(str).tolist()
        Revigo_ana(Input_revigo)



inpu_csv_file="pythonTest.csv"
data = pd.read_csv(inpu_csv_file)
data.rename(columns={list(data)[0]: 'genes'}, inplace=True)
query = data['genes'].tolist()

specie = 'hsapiens'
correction_method = 'fdr'
database = ["GO:BP"]
state_threshold = 0.05

enrich_ana(specie, correction_method, database, state_threshold)

