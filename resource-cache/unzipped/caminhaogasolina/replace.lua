txd = engineLoadTXD("578.txd")
engineImportTXD(txd, 403)
dff = engineLoadDFF("578.dff", 403)
engineReplaceModel(dff, 403)

-- generated with http://mta.dzek.eu/