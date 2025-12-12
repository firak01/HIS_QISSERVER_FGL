Auftrag, der zusammen mit dem Zulassungsbescheid verwendet wird 
und auch eine eigene Bescheidanforderung bekommt.
Besonderheit ist, das bis auf einen Kopf der gesamte Text aus einem Oberflächentext stammt.
Schlüssel des Oberflächentexts: cm.app.reports.approvalinfo.content.Hinweisfeld 

- Voraussetzung Bescheidkenzeichen "Zulassungsinformation"

- Zudem gibt es ein fachliches Ereignis, das dann die Bescheidanforderung erstellt.

Anwendung:
Unter "Bescheide Sichten" den Bewerbungsantrag auf "zugelassen" setzen.
Anschliessend steht unter Bescheide Drucken der Auftrag "Zulassungsinformation_ENGLISCH" zur Verfügung.
Diesen ausführen.

- Realisiert als:
  Reiner Publish Auftrag 

In der .xml Datei wird auf die report-id des Bescheidkennzeichens (bzw. die Hiskeyid davon) abgeprueft.
Zudem wird hier der Oberflächentext geholt unter der Wildcard: cm.app.reports.approvalinfo.*

siehe hier:
<Transform.Plugin ElementName="uitext">
				<class name="de.his.printout.publishModul.plugins.core.GetUITextPluginArgsubstWithVelocity">
					<uiText key="cm.app.reports.approvalinfo.*" keepInStore="n" argsubstKeep="true" language='en'/>
					<uiText key="cm.app.reports.common.*" keepInStore="n" argsubstKeep="true" language='en'/>
				</class>
			</Transform.Plugin>