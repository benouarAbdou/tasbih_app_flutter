package com.example.tasbih

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class MyWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // Loop through all widget instances
        for (appWidgetId in appWidgetIds) {
            // Create RemoteViews object to update the widget's layout
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.my_widget_layout).apply {

            // Optionally, update text here with default values or from saved data
            val title = widgetData.getString("dikr_name", "أستغفر الله")
                setTextViewText(R.id.dikr_name, title ?: "أستغفر الله")

                val myval = widgetData.getString("dikr_value", "0")
                setTextViewText(R.id.dikr_value, myval ?: "0")

            }
            // Update the widget with the layout
        appWidgetManager.updateAppWidget(appWidgetId, views)
        }
            

    }
}
